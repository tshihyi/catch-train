function group-list list, key, transform
  [{}]concat list .reduce (data, entry) ->
    data[key entry] = (data[key entry] || [])concat transform entry
    data

function prepare {date-groups, time-entries} date
  console.log date
  included = Object.assign ...date-groups[date]map -> (it + 1): true
  active-entries = time-entries.filter -> included[it.group]

  stations: active-entries.reduce (data, {station, train, departure}) ->
    data[station] = (data[station] || [])concat {train, departure}
    data
  trains: group-list active-entries, (.train), -> it{station, departure}

reduce =
  timetable: ({date} payload) ->
    Object.assign {} payload, prepare payload, date

export {reduce}
