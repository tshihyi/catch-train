import \./link : {h}

function selection {options, value, on-change}
  children = Object.entries options .map ([key, label]) ->
    h \option value: key, selected: value == key, label: label, label
  h \select {on-change} children

function local-time date
  if date
    d = new Date date
    d.set-minutes d.get-minutes! - d.get-timezone-offset!
    d.to-JSON!slice 0 16

function UTC-time on-change => (target: {value}) ->
  value = new Date value .to-JSON!
  on-change target: {value}

function date-input {value, on-change, ...attrs}
  h \input Object.assign {},
    type: \datetime-local
    value: local-time value
    on-change: UTC-time on-change
    attrs

export {date-input, selection}
