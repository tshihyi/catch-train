import \./stations : {station-names}

function options-state {options}: state
  Object.assign {} options, station-names: station-names state

function set-options target: {value}, key
  type: \set-options payload: (key): value

function input-props items, mock-bind
  entries = Object.entries items .map ([key, value]) ->
    (key): value: value, on-change: mock-bind set-options, key
  Object.assign ...entries

function options-props {station-names, time, type, location} bind-action
  Object.assign {},
    input-props {type, location, time: time.slice 0 16} bind-action
    stations: station-names

reduce =
  \set-options : (, payload) -> payload

export {reduce, options-state, options-props}
