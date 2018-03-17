import
  \./link : {h, link}
  \./input : {selection, date-input}
  \./options : {option-state, option-props}
  \./suggestions : {suggestions-state, suggestions-props}
  \./suggestion-block : suggestion-block

suggestions = link suggestion-block, suggestions-state, suggestions-props

function link-option component
  link component, option-state, option-props

selection-option = link-option selection
date-option = link-option date-input

export {date-option, selection-option, suggestions}
