import \../src/timetable : {reduce}

function main t
  state = date: \0307
  payload =
    date-groups: '0307': [0]
    time-entries:
      * train: 3 station: 5 departure: '12:23' group: 1
      * train: 3 station: 6 departure: '12:27' group: 1
      * train: 4 station: 6 departure: '12:33' group: 1
      * train: 4 station: 8 departure: '12:47' group: 1
  update = reduce.timetable state, payload

  actual = update.date-groups
  expected = payload.date-groups
  t.is actual, expected, 'store date groups'

  actual = update.time-entries
  expected = payload.time-entries
  t.is actual, expected, 'store time entries'

  actual = update.stations.6.0
  expected = train: 3 departure: '12:27'
  t.same actual, expected, 'prepare station lookup lists'

  actual = update.trains.3.1
  expected = station: 6 departure: '12:27'
  t.same actual, expected, 'prepare train lookup list'

  t.end!

export default: main
