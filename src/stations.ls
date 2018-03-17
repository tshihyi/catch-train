reduce =
  stations: (, payload) -> payload

function station-names {stations, options: {language}}
  entries = Object.entries stations[language] .filter ([, value]) ->
    /台南|新左營|高雄/test value
  Object.assign {} ...entries.map ([key, value]) -> (key): value


export {reduce, station-names}
