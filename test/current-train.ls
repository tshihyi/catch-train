import
  \../src/current-train : {train-state, train-props}
  \../src/preload-state : preload-state

function main t
  state = {}
  actual = train-state state
  expected = state
  t.is actual, expected, 'parts of state related to the component'
  
  state = preload-state!
  props = train-props state

  actual = props.departure
  expected = \18:12
  t.is actual, expected, 'next train departure time'

  actual = props.arrival
  expected = \18:37
  t.is actual, expected, 'next train arrival time'

  t.end!

export default: main
