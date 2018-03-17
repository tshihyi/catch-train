import \../src/timetable : {reduce}

function main t
  state = {}
  payload =
    1242:
      * train: \3142 time: '09:43'
      * train: \3314 time: '09:52'
    1228:
      * train: \3718 time: '10:16'
      * train: \3142 time: '10:27'
  update = reduce.timetable state, payload

  actual = update.stations.1242.0
  expected = train: \3142 time: '09:43'
  t.same actual, expected, 'prepare station lookup lists'

  actual = update.trains?3.1
  expected = station: 6 departure: '12:27'
  #TODO prepare train list

  t.end!

export default: main
