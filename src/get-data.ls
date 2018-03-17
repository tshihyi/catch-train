function try-parse
  result = void
  try result := JSON.parse it
  result

source =
  stations: 'https://gistcdn.githack.com/dk00/66edd93eb6b737fb2b8acc7f987ff25d/raw/fdfc496fb22e36721ba18d2ed39f1e2b9feb57aa/tra-stations.json'
  timetable: 'http://dk00.herokuapp.com/station-tables'

function request-key {time='', start='', destination=''}
  [time.slice 0 10]concat [start, destination]sort! .join '/'

function query-string {time='', start, destination}
  if time
    "?date=#{time.slice 0 10}&stations=#start&stations=#destination"
  else ''

function offline-data {path, ...parameters} load
  key = path + '/' + request-key parameters
  if try-parse local-storage[key] then load that
  fetch source[path] + query-string parameters .then (.json!) .then ->
    load it
    local-storage[key] = JSON.stringify it

function setup-data {load-stations, load-timetable}
  offline-data path: \stations, load-stations
  (options) ->
    request = Object.assign path: \timetable, options
    offline-data request, load-timetable

function get-data store
  update-options = setup-data {
    load-stations: -> store.dispatch type: \stations payload: it
    load-timetable: -> store.dispatch type: \timetable payload: it
  }
  prev-options = ''
  handle-changes = ->
    options = store.get-state!.options
    key = request-key options
    if prev-options != key
      prev-options := key
      update-options options
  store.subscribe handle-changes
  handle-changes!

export default: get-data
