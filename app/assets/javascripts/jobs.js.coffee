# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
    #Check the job title length 
    job_title_max_length = 60
    job_title_min_length = 5
    
    $('#job_title_field').keyup ->
        text_length = $('#job_title_field').val().length
        text_remaining = job_title_max_length - text_length
        
        if text_length < 6
            text_needed = job_title_min_length - text_length
            $('#job_title_field_feedback').html "#{text_needed} characters needed"
        
        else
            $('#job_title_field_feedback').html "#{text_remaining} characters remaining"
        
    $('#job_title_field').keydown ->
        text_length = $('#job_title_field').val().length
        text_remaining = job_title_max_length - text_length
        
        if text_length < 6
            text_needed = job_title_min_length - text_length
            $('#job_title_field_feedback').html "#{text_needed} characters needed"
        
        else
            $('#job_title_field_feedback').html "#{text_remaining} characters remaining"
    
    
    #Check the job decription length 
    job_description_max_length = 500
    job_description_min_length = 5 
    
    $('#job_description_field').keyup ->
        text_length = $('#job_description_field').val().length 
        text_remaining = job_description_max_length - text_length
        
        if text_length < 5 
            text_needed = job_description_min_length - text_length
            $('#job_description_field_feedback').html "#{text_needed} characters needed"
            
        else 
            $('#job_description_field_feedback').html "#{text_remaining} characters remaining"
            
    $('#job_description_field').keydown ->
        text_length = $('#job_description_field').val().length 
        text_remaining = job_description_max_length - text_length
        
        if text_length < 5 
            text_needed = job_description_min_length - text_length
            $('#job_description_field_feedback').html "#{text_needed} characters needed"
            
        else 
            $('#job_description_field_feedback').html "#{text_remaining} characters remaining"