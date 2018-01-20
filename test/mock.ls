mock-event =
  target: value: \mock-value
  prevent-default: ->
  stop-propagation: ->

function mock-bind create-action, options
  create-action? mock-event, options or create-action

function create-event target
  Object.assign {} mock-event, {target}

function mock-handler
  handle-event = (target: {value}) -> handle-event.value = value

function bind-with {state, value}
  get-state = -> state
  e = create-event {value}
  (action, props) -> action? e, props, get-state or action

export {mock-bind, create-event, mock-handler, bind-with}
