import \../firebase.app.json : app-options

function q selector
  document.query-selector selector

function h tag-name, attributes
  element = document.create-element tag-name
  Object.assign element, attributes

function import-external url
  new Promise (resolve) ->
    attributes = src: url, onload: resolve
    document.body.append h \script attributes

asset-list =
  '//www.gstatic.com/firebasejs/4.8.1/firebase.js'
  '//www.gstatic.com/firebasejs/4.8.1/firebase-firestore.js'

function firestore
  [Promise.resolve!]concat asset-list .reduce (last, next) ->
    last.then -> import-external next
  .then ->
    firebase.initialize-app app-options
    firebase.firestore!

export {default: firestore}
