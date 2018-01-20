import \./format : {format-date}

function next-hours
  d = new Date
  d.set-hours d.get-hours! + it
  d.to-JSON!

function preload-state
  options:
    type: \destination location: \1228 time: next-hours 24
    language: \zh

  stations: zh: {}

  timetable:
    date: format-date next-hours 24
    date-groups: {} time-entries: []

  now: \17:44
  current-location: \tainan
  destination: \xinzoying
  #1242

  timetable0:
    * type: \自強號
      items:
        * time: \13:50
          location: \taipei
        * time: \16:00
          location: \taichung
        * time: \18:12
          location: \tainan
          delay: \3
        * time: \18:37
          location: \xinzoying

    * type: \光速號
      items:
        * time: \19:22
          location: \tainan
          delay: \3
        * time: \19:35
          location: \xinzoying

export default: preload-state
