import
  \./link : {link}
  \./train-notice : train-notice

function train-state state
  state

# lookup next train time > now
# lookup train departure location = current location
# lookup train arrival location = destination

function location-time train, location
  train.items.find -> it.location == location
  .time

function train-props {now, current-location, destination, timetable}
  next-train = timetable.find ->
    it.items.some ->
      it.location == current-location && it.time > now
  debug: next-train
  departure: location-time next-train, current-location
  arrival: location-time next-train, destination

current-train = link train-notice, train-state, train-props

export {default: current-train}, {train-state}, {train-props}
