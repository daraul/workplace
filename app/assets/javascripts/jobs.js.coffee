# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
ready = ->
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
            
            
    #Validate the new job form 
    #Putting this at the top of the JS file for some reason broke the character coutners. I'm not sure why, but putting it down here seems to work fine 
     $('#new_job_form').submit -> 
        job_description_regex = /^[A-z0-9\.\\\/\(\)\?\$\&\,\s]{5,500}$/
        job_title_regex = /^[A-z0-9\.\\\/\(\)\?\$\&\s]{5,60}$/
        
        #Validate the job title first 
        if job_title_regex.test($('#job_title_field').val())
            #If the job title passes, then test the description next 
            if job_description_regex.test($('#job_description_field').val())
                #Test the user ID presence, now, since the description passes 
                if $("#job_user_id").val() != null 
                    #Test the project presence, now, since the user ID passes 
                    if $("#job_project_id").val() != null 
                        #Finally return true since everything works 
                        return true 
                    else 
                        alert "Project ID isn't present!"
                        return false 
                #User ID else 
                else 
                    alert "User ID isn't present!"
                    return false 
            #Job description else 
            else 
                $('input[type="submit"]').blur() #You have to blur the submit button 
                $('#job_description_field').focus() #to get to the job description 
                $('#job_description_field_feedback').html "Something was wrong here!"
                return false 
        #Job title else 
        else  
            $('input[type="submit"]').blur() #You have to blur the submit button 
            $('#job_title_field').focus() #to get to the job description 
            $('#job_title_field_feedback').html "Something was wrong here!"
            return false 
            
$(document).on('page:change', ready)