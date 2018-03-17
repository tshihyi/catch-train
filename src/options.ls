import \./stations : {station-names}

target-types =
  start: '出發'
  destination: '抵達'

option-source =
  station: station-names
  \target-type : -> target-types

function option-state {options}: state, props
  {name, select, ...attrs} = props
  name: name, value: options[name], attrs: attrs
  options: option-source[select]? state

function set-options target: {value}, key
  type: \set-options payload: (key): value

function option-props {name, value, options, attrs} bind-action
  Object.assign {value, options},
    on-change: bind-action set-options, name
    attrs

reduce =
  \set-options : (, payload) -> payload

export {reduce, option-state, option-props}
