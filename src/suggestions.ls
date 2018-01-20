import
  \./format : {format-time}
  \./stations : {station-names}

function suggestions-state {options, timetable}: state
  Object.assign options{location, type, time},
    timetable{stations, trains}, station-names: station-names state

function suggestions-props {location, time, stations={}, trains={}, station-names}
  formated-time = format-time time
  target = stations[location]
  if target
    last = target.find-index -> formated-time < it.departure
    index = if last < 0 then target.length - 1 else last - 1
    target-train = trains[target[index]train]
    end = target-train.find-index -> it.station == location
    items: target-train.slice 0 end .map ->
      station: station-names?[it.station] || it.station
      departure: it.departure
      arrival: target[index]departure
  else items: []

export {suggestions-state, suggestions-props}
