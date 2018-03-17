import
  \./format : {format-time}
  \./stations : {station-names}

function suggestions-state {options, timetable}: state
  Object.assign options{start, destination, type, time},
    timetable{stations, trains}, station-names: station-names state

function map-parameters wrap, compare => (a, b) ->
  compare (wrap a), wrap b

function descend a, b
  switch
  | a > b => -1
  | a == b => 0
  | a < b => 1

function suggestions-props {
  start, destination, type, time, stations={}, trains={}
}
  formated-time = format-time time
  another = stations[start] || []
  items: (stations[destination] || [])filter -> it.time <= formated-time
  .sort map-parameters (.time), descend
  .map ({train, time}) ->
    train: train
    arrival: time
    departure: another.find (.train == train) ?.time
  .filter -> it.departure < it.arrival
  .slice 0 5

export {suggestions-state, suggestions-props}
