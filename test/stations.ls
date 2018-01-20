import \../src/stations : {station-names}

function main t
  state =
    options: language: \zh
    stations: zh: \stations

  actual = station-names state
  expected = \stations
  t.is actual, expected, 'get station names for current language'

  t.end!

export default: main
