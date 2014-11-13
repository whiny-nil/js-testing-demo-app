class @ContactWidget
  constructor: (container) ->
    @template = JST['features/contact_widget/contact_widget_template']({})
    @$container = $(container)
    @valid = false
    @errors = []
    @render()
    @setupElements()
    @setupEvents()

  render: =>
    @$container.html(@template)

  setupElements: =>
    @$widget = $('.contact-widget')
    @$toggleBtn = @$widget.find('.toggle-btn')
    @$form = @$widget.find('.form')
    @$submitBtn = @$widget.find('input[type=submit]')
    @$emailField = @$widget.find('input[name=email]')
    @$messageField = @$widget.find('textarea[name=message]')
    @$messageBox = @$widget.find('.message-box')

  setupEvents: =>
    @$toggleBtn.on 'click', @toggleForm
    @$submitBtn.on 'click', @processForm

  toggleForm: =>
    @$form.toggle()

  processForm: (e) =>
    e.preventDefault()
    @$messageBox.hide()
    if @formIsValid()
      # submit
      @showNotice "Thanks! We'll get back to you soon!"
    else
      msg = "<ul>"
      msg += "<li>#{error}</li>" for error in @errors
      msg += "</ul>"
      @showWarning msg

  formIsValid: =>
    @valid = true
    @errors = []
    @emailValidator()
    @messageValidator()

    @valid

  emailValidator: =>
    email = @$emailField.val()
    unless email
      @valid = false
      @errors.push "Email cannot be blank"

  messageValidator: =>
    message = @$messageField.val()
    unless message
      @valid = false
      @errors.push "Message cannot be blank"

  showWarning: (msg) =>
    @$messageBox.removeClass "notice"
    @$messageBox.addClass "warning"
    @$messageBox.html(msg)
    @$messageBox.show()

  showNotice: (msg) =>
    @$messageBox.removeClass "warning"
    @$messageBox.addClass "notice"
    @$messageBox.html(msg)
    @$messageBox.show()
