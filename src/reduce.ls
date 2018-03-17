import
  \./timetable : reduce: timetable
  \./stations : reduce: stations
  \./options : reduce : options
dummy = (state) -> state || 1

reducers =
  timetable: timetable
  options: options
  stations: stations

export default: reducers
