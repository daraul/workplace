# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'page:change', () ->
    $("#todos .edit_todo input[type=submit]").hide(); 
    
    $("#todo .edit_todo input[type=submit]").hide(); 
    $("#parents .edit_todo input[type=submit]").hide(); 
    $("#children .edit_todo input[type=submit]").hide(); 
    
    $("body").on 'change', '#todos .edit_todo .completed, #todo .edit_todo .completed, #parents .edit_todo .completed, #children .edit_todo .completed', () ->
        $(this.parentElement).submit()