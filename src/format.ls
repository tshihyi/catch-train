function pad-join items, char=''
  items.map -> ('' + it)pad-start 2 '0'
  .join char

function format-date
  new Date it .toJSON!slice 0 10

function format-time
  d = new Date it
  pad-join [d.get-hours!, d.get-minutes!] ':'

export {format-date, format-time}
