# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# This line is apparently needed to execute the code AFTER the document is ready. Otherwise this won't work :( 
$ ->
    $('#project_name_field').attr "aria-required", "true"
    
    project_title_max_length = 35
    
    $('#project_name_field').keyup ->
        text_length = $('#project_name_field').val().length
        text_remaining = project_title_max_length - text_length
        
        $('#project_name_field_feedback').html "#{text_remaining} characters remaining"
        
    $('#project_name_field').keydown ->
        text_length = $('#project_name_field').val().length
        text_remaining = project_title_max_length - text_length
        
        $('#project_name_field_feedback').html "#{text_remaining} characters remaining"