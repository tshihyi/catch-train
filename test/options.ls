import
  \./mock : {mock-bind}
  \../src/options : {options-state, options-props, reduce}

function main t
  actual = reduce\set-options {} \payload
  expected = \payload
  t.is actual, expected, 'merge options'

  state =
    options: location: 1228 language: \zh
    stations: zh: \stations-zh
  sub-state = options-state state

  actual = sub-state.location
  expected = 1228
  t.is actual, expected, 'get options from state'

  actual = sub-state.station-names
  expected = \stations-zh
  t.is actual, expected, 'get stations list from state'

  state = location: 1228 time: '2018-01-12T00:59' stations: 1228: \台南
  props = options-props state, mock-bind

  actual = props.location.value
  expected = 1228
  t.is actual, expected, 'pass station id'

  actual = props.time.value
  expected = '2018-01-12T00:59'
  t.is actual, expected, 'pass departure/arrival time'

  actual = props.time.on-change
  expected = type: \set-options payload: time: \mock-value

  t.end!

export default: main
