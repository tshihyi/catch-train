import
  \./mock : {mock-bind}
  \../src/options : {option-state, option-props, reduce}

function main t
  actual = reduce\set-options {} \payload
  expected = \payload
  t.is actual, expected, 'merge options'

  state =
    options: start: 1242 destination: 1228 language: \zh
    stations: zh: \stations-zh
  sub-state = option-state state, name: \destination select: \station

  actual = sub-state.value
  expected = 1228
  t.is actual, expected, 'get option value from state'

  actual = sub-state.options
  expected = \stations-zh
  t.is actual, expected, 'get stations list from state'

  state = value: 1228 name: \destination options: 1228: \台南
  props = option-props state, mock-bind

  actual = props.value
  expected = 1228
  t.is actual, expected, 'pass station id'

  actual = props.on-change
  expected = type: \set-options payload: destination: \mock-value
  t.same actual, expected, 'set state option value on input change'

  t.end!

export default: main
