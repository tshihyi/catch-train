function preload-state
  now: \17:44
  current-location: \tainan
  destination: \xinzoying

  timetable:
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
