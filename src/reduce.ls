import
  \./timetable : reduce: timetable
  \./stations : reduce: stations
  \./options : reduce : options
dummy = (state) -> state || 1

reducers =
  timetable: timetable
  options: options
  stations: stations
  timetable0: dummy
  now: dummy, current-location: dummy, destination: dummy

export default: reducers
