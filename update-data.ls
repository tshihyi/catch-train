http = require \http
unzip = require \unzip-stream

function async-pipe ...fns => (initial) ->
  fns.reduce ((y, f) -> Promise.resolve y .then f), initial

function source-url date
  "http://163.29.3.98/json/#{date}.zip"

function fetch-stream url
  request = http.get url
  request.end!
  new Promise (resolve, reject) ->
    request.once \response resolve
    request.once \error reject

function collect
  buffer = []
  it.set-encoding \utf8
  it.on \data -> buffer.push it
  new Promise (resolve) ->
    it.on \end -> resolve buffer.join ''

function extract-train stream
  parser = stream.pipe unzip.Parse!
  new Promise (resolve) -> parser.on \entry resolve

fetch-train = async-pipe fetch-stream, extract-train, collect

function try-parse
  result = void
  try
    result := JSON.parse it
  result

function timetable-entries raw-data
  trains = try-parse raw-data ?.TrainInfos || []
  []concat ...trains.map ({Train: train, TimeInfos: entries}) ->
    entries.map ({Station: station, DepTime: departure}) ->
      {station, train, departure: departure.slice 0 5}
    .sort!

function hash-entry
  it<[station train departure]>join ' '

function merge-entries data, {date, entries}
  entries.for-each ->
    key = hash-entry it
    if !(key of data)
      data[key] = entry: it, date-list: []
    data[key]date-list.push date
  data

function round-up data
  groups = []
  group-id = {}
  items = Object.values data
  items.for-each ->
    key = it.date-list.join ' '
    if !(key of group-id)
      groups.push it.date-list
      group-id[key] = groups.length

  date-groups = {}
  groups.for-each (list, id) ->
    list.for-each (date) ->
      date-groups[date] = (date-groups[date] || [])concat id

  time-entries: items.map ->
    Object.assign {} it.entry, group: group-id[it.date-list.join ' ']
  date-groups: date-groups

function add a, b => a + b

function try-update ref, data
  ref.get!then (doc) ->
    if !doc.exists || doc.data!group != data.group
      ref.set data

function push-update db, {date-groups, time-entries}
  db.collection \public .doc \date-groups .set date-groups
  Promise.all time-entries.map ->
    ref = db.collection \time-entries .doc hash-entry it
    try-update ref, it

function main
  firebase = require \firebase-admin
  firebase.initialize-app credential:
    firebase.credential.cert require \./firebase.admin.json
  db = firebase.firestore!

  range = [\20180302 \20180303]
  range = Array.from length: 3 .map (, i) ->
    d = new Date
    d.set-date d.get-date! + i
    [d.get-full-year!, d.get-month! + 1, d.get-date!]
    .map -> ('' + it)pad-start 2 '0' 2
    .join ''

  Promise.all range.map (date) ->
    console.log \loading date
    fetch-train source-url date .then ->
      console.log \loaded date
      {date, entries: timetable-entries it}
  .then -> it.reduce merge-entries, {}
  .then round-up
  .then ->
    date-groups = Object.values it.date-groups
    meta =
      groups: Math.max ...[]concat ...date-groups
      group-data-size: date-groups.map (.length) .reduce (add)
      entries: it.time-entries.length
    console.log JSON.stringify it,, 2
    console.log meta
    push-update db, it
  .then -> console.log \updated

main!
