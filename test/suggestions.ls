import \../src/suggestions : {suggestions-state, suggestions-props}

function main t
  state =
    options:
      start: \start destination: \destination
      type: \type time: \time
      language: \zh
    timetable: stations: \stations trains: \trains
    stations: zh: {}

  actual = suggestions-state state
  expected =
    start: \start destination: \destination
    type: \type time: \time
    stations: \stations trains: \trains
    station-names: {}
  t.same actual, expected, 'get sub state for suggestions'

  stations =
    1228: [train: 116 time: '09:36']
    1242: [train: 116 time: '09:09']
  trains = 116:
    * station: \1242 time: '09:09'
    * station: \1228 time: '09:36'
  state =
    start: \1242 destination: \1228 type: \destination
    time: '2018-01-20T02:00:00.000Z'
    stations: stations, trains: trains
  props = suggestions-props state

  actual = props.items.0
  expected = departure: '09:09' arrival: '09:36'
  t.same actual, expected, 'list suggested trips'

  t.end!

export default: main
