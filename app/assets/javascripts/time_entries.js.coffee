# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->
    $("#time_entry_start").datetimepicker()
    $("#time_entry_finish").datetimepicker()
    
    time_entry_description_length_max = 500
    time_entry_description_length_min = 5 
    
    $('#time_entry_description').keyup ->
        text_length = $('#time_entry_description').val().length
        text_remaining = time_entry_description_length_max - text_length
        
        if text_length < 6
            text_needed = time_entry_description_length_min - text_length
            $('#time_entry_description_feedback').html "#{text_needed} characters needed"
        
        else
            $('#time_entry_description_feedback').html "#{text_remaining} characters remaining"
        
    $('#time_entry_description').keydown ->
        text_length = $('#time_entry_description').val().length
        text_remaining = time_entry_description_length_max - text_length
        
        if text_length < 6
            text_needed = time_entry_description_length_min - text_length
            $('#time_entry_description_feedback').html "#{text_needed} characters needed"
        
        else
            $('#time_entry_description_feedback').html "#{text_remaining} characters remaining"

    $('#new_time_entry_form').submit ->
        time_entry_description_regex = /^[A-z0-9\.\\\/\(\)\?\$\&\,\s]{5,500}$/
        year_regex = /^\d{1,4}$/
        month_regex = /^[1-9]$|^1[0-2]$/
        day_regex = /^[1-9]$|^(1|2)[0-9]$|^3[0-1]$/
        hour_regex = /^(0|1)[0-9]$|^2[0-3]$/
        minute_regex = /^[0-5][0-9]$/
        
        if time_entry_description_regex.test($("#time_entry_description").val())
            #Description passes, test the start date 
            if $("#time_entry_start").val()
                #Start date passes. Test that the Finish date passes as well and that it is AFTER the start date 
                if $("#time_entry_finish").val()
                    #Finish date passes, test the job_id next 
                    if isNaN($("#time_entry_job_id").val())
                        $("#time_entry_job_id_feedback").html "Job ID must be a number!"
                        return false 
                    else 
                        #Job ID passes as a number, test the user_id 
                        if isNaN($("#time_entry_user_id").val())
                            $("#time_entry_user_id_feedback").html "User ID must be a number!"
                            return false 
                        else 
                            return true 
                else 
                    $("#time_entry_finish_feedback").html "Something was wrong here!"
                    return false 
            else 
                $("#time_entry_start_feedback").html "Something was wrong here!"
                return false 
        else
            $('input[type="submit"]').blur() 
            $("#time_entry_description").focus()
            $("#time_entry_description_feedback").html "Something was wrong here!"
            return false

$(document).on('page:change', ready)