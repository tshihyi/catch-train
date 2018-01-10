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
      {station, train, departure}

function merge-groups {groups, group-id, tables} {date, entries}
  new-groups = []
  group-map = {}
  new-id = {}
  entries.for-each ->
    id = group-id[hash it]
    if !(id of group-map)
      group-map[id] = new-groups.length
      new-groups.push []
    index = group-map[id]
    new-id[key] = groups.length + index
    new-groups[index]push it

function clean-up
  it

function main
  range = [\20180302 \20180303]

  Promise.all range.map (date) ->
    fetch-train source-url date .then ->
      {date, entries: timetable-entries it}
  .then -> it.reduce merge-groups, {}
  .then clean-up
  .then ->
    console.log JSON.stringify it,, 2

main!
