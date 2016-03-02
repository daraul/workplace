$(document).on 'page:change', () ->
    developerKey = 'AIzaSyAboSgr62_7xGQn6CffBAX6eK_VwazAiI8';
    
    clientId = "1065576112136-nkpjqh8uqakcbco7r5rvk403atu3lkrj.apps.googleusercontent.com"
    
    appId = "1065576112136";
    
    scope = ['https://www.googleapis.com/auth/drive'];
    
    pickerApiLoaded = false
    
    oauthToken = undefined
    
    loadPicker = () ->
        gapi.load('auth', {'callback': onAuthApiLoad});
        gapi.load('picker', {'callback': onPickerApiLoad});
        
    onAuthApiLoad = () ->
        window.gapi.auth.authorize({
                'client_id': clientId,
                'scope': scope,
                'immediate': false
            },
            handleAuthResult
        )
        
    onPickerApiLoad = () ->
        pickerApiLoaded = true
        createPicker()
        
    handleAuthResult = (authResult) ->
        if authResult && !authResult.error 
            oauthToken = authResult.access_token
            createPicker()
    
    createPicker = () ->
        uploadView = new google.picker.DocsUploadView();
        
        selectView = new google.picker.DocsView();
        
        if pickerApiLoaded && oauthToken
            picker = new google.picker.PickerBuilder().
                addView(selectView).
                addView(uploadView).
                enableFeature(google.picker.Feature.MULTISELECT_ENABLED).
                setOAuthToken(oauthToken).
                setDeveloperKey(developerKey).
                setCallback(pickerCallback).
                build();
            
            picker.setVisible(true)
        
    pickerCallback = (data) ->
        url = undefined
        if data[google.picker.Response.ACTION] == google.picker.Action.PICKED
            filename = data.docs[0].name
            url = data.docs[0].url
            
            window.data = data 
            
            attachments_fields = ""
            
            i = 0
            
            while i < data.docs.length
                doc = data.docs[i]
                
                attachments_fields += 
                    "<div class=\"field\">" + 
                        "<label for=\"todo[datafiles_attributes][#{i}][filename]\">File Name</label>" +
                        "<input " + 
                            "name=\"todo[datafiles_attributes][#{i}][filename]\" " + 
                            "id=\"todo_datafiles_attributes_#{i}_filename\" " + 
                            "type=\"text\" " + 
                            "value=\"#{doc.name}\">" +
                    "</div>" + 
                    "<div class=\"field\">" + 
                        "<input " + 
                            "name=\"todo[datafiles_attributes][#{i}][url]\" " + 
                            "id=\"todo_datafiles_attributes_#{i}_url\" " + 
                            "type=\"hidden\" " + 
                            "value=\"#{doc.url}\">" +
                    "</div>"
                    
                i++
                
            $("#add_attachments").append(attachments_fields)

        
    $("#add_attachment").on 'click', () ->
        if pickerApiLoaded && oauthToken
            createPicker()
        else 
            loadPicker()