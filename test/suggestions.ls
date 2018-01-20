import \../src/suggestions : {suggestions-state, suggestions-props}

function main t
  state =
    options: location: \location type: \type time: \time
    timetable: stations: \stations trains: \trains
    stations: {}

  actual = suggestions-state state
  expected =
    location: \location type: \type time: \time
    stations: \stations trains: \trains
    station-names: void
  t.same actual, expected, 'get sub state for suggestions'

  stations = 1228: [train: 116 departure: '09:36']
  trains = 116:
    * station: \1242 departure: '09:09'
    * station: \1228 departure: '09:36'
  state =
    location: \1228 type: \destination time: '2018-01-20T10:00:00.000Z'
    stations: stations, trains: trains
    station-names: 1242: \新左營
  props = suggestions-props state

  actual = props.items.0
  expected = station: \新左營 departure: '09:09' arrival: '09:36'
  t.same actual, expected, 'list suggested trips'

  t.end!

export default: main
