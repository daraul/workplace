# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->
    organization_title_max_length = 35
    organization_title_min_length = 6 
    
    $('#organization_name_field').keyup ->
        text_length = $('#organization_name_field').val().length
        text_remaining = organization_title_max_length - text_length
        
        if text_length < 6
            text_needed = organization_title_min_length - text_length
            $('#organization_name_field_feedback').html "#{text_needed} characters needed"
        
        else
            $('#organization_name_field_feedback').html "#{text_remaining} characters remaining"
        
    $('#organization_name_field').keydown ->
        text_length = $('#organization_name_field').val().length
        text_remaining = organization_title_max_length - text_length
        
        if text_length < 6
            text_needed = organization_title_min_length - text_length
            $('#organization_name_field_feedback').html "#{text_needed} characters needed"
        
        else
            $('#organization_name_field_feedback').html "#{text_remaining} characters remaining"
        
        
$(document).on('page:change', ready)