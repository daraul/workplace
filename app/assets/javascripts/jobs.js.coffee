# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
ready = ->
    #Check the job title length 
    job_title_max_length = 60
    job_title_min_length = 5
    
    $('#job_title_field').keyup ->
        console.log 'key pressed!'
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
            
            
    #Validate the new job form 
    #Putting this at the top of the JS file for some reason broke the character coutners. I'm not sure why, but putting it down here seems to work fine 
     $('#new_job_form').submit -> 
        job_description_regex = /^[A-z0-9\.\\\/\(\)\?\$\&\,\s]{5,500}$/
        
        if job_description_regex.test($('#job_description_field').val())
            return true 
        else 
            console.log "Input was invalid!"
            return false 
            
$(document).on('page:change', ready)