import \./firestore : firestore

function try-parse
  result = void
  try result := JSON.parse it
  result

function fetch-timetable
  firestore!then (db) ->
    groups = db.collection \public
    .doc \date-groups .get!then -> it.data!
    time-entries = db.collection \time-entries .order-by \departure
    .get!then -> it.docs.map -> it.data!
    Promise.all [groups, time-entries] .then ([date-groups, time-entries]) ->
      {date-groups, time-entries}

station-source = 'https://gistcdn.githack.com/dk00/66edd93eb6b737fb2b8acc7f987ff25d/raw/fdfc496fb22e36721ba18d2ed39f1e2b9feb57aa/tra-stations.json'
function fetch-stations
  fetch station-source .then (.json!)

dataset =
  timetable: fetch-timetable
  stations: fetch-stations

function get-data store
  Object.entries dataset .for-each ([key, fetch-data]) ->
    request = if try-parse local-storage[key] then Promise.resolve that
    else fetch-data!
    request.then ->
      store.dispatch type: key, payload: it
      it
    .then ->
      if! local-storage[key] then local-storage[key] := JSON.stringify it

export default: get-data
