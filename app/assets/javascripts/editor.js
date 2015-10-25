//= require 'epiceditor'
var loadEditor = function() {
  var editor = new EpicEditor().load();
}
$(document).ready(loadEditor);
$(document).on('page:load', loadEditor);
