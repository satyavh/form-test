if Meteor.isClient

  Template['changePasswordForm'].helpers
    schema: ->
      new SimpleSchema(
        currentPassword:
          type: String
          min: 4
          instructions: 'Current password'
          label: 'Current password'
        newPassword:
          type: String
          min: 4
          label: 'New password'        
        confirmPassword:
          type: String
          min: 4
          label: 'Confirm new password'   
          custom: ->
            if @value != @field('newPassword').value 
              return "passwordMismatch"
            true

      )
    action: ->
      (els, callbacks, changed) ->

        Accounts.changePassword(@currentPassword, @newPassword, (error) ->
          unless error
            callbacks.success()
            callbacks.reset()
          else
            callbacks.failed()
        )


  Template['formBlock'].helpers
    isNull: ->   
      if arguments[0] == 0 and arguments[1] == false
        return false
      else
        return true

  SimpleSchema.messages
    passwordMismatch: "New passwords do not match."
    
  ReactiveForms.createElement
    template: 'inputField'
    validationEvent: 'keyup'
    reset: (el) ->
      $(el).val(null)

  ReactiveForms.createElement
    template: 'passwordField'
    validationEvent: 'keyup'  
    reset: (el) ->
      $(el).val(null)

  ReactiveForms.createFormBlock
    template: 'formBlock'
    submitType: 'normal'  