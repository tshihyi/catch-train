function group-list list, key, transform
  [{}]concat list .reduce (data, entry) ->
    data[key entry] = (data[key entry] || [])concat transform entry
    data

function prepare data
  stations: data

reduce =
  timetable: ({date} payload) -> prepare payload

export {reduce}
