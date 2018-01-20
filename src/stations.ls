reduce =
  stations: (, payload) -> payload

function station-names {stations, options: {language}}
  stations[language]

export {reduce, station-names}
