# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# This line is apparently needed to execute the code AFTER the document is ready. Otherwise this won't work :( 
ready = ->
    project_title_max_length = 35
    project_title_min_length = 6 
    
    $('#project_name_field').keyup ->
        text_length = $('#project_name_field').val().length
        text_remaining = project_title_max_length - text_length
        
        if text_length < 6
            text_needed = project_title_min_length - text_length
            $('#project_name_field_feedback').html "#{text_needed} characters needed"
        
        else
            $('#project_name_field_feedback').html "#{text_remaining} characters remaining"
        
    $('#project_name_field').keydown ->
        text_length = $('#project_name_field').val().length
        text_remaining = project_title_max_length - text_length
        
        if text_length < 6
            text_needed = project_title_min_length - text_length
            $('#project_name_field_feedback').html "#{text_needed} characters needed"
        
        else
            $('#project_name_field_feedback').html "#{text_remaining} characters remaining"
        
$(document).on('page:change', ready)