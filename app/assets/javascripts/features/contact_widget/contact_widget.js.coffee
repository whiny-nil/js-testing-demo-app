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

  setupEvents: =>
    @$toggleBtn.on 'click', @toggleForm
    @$submitBtn.on 'click', @processForm

  toggleForm: =>
    @$form.toggle()

  processForm: (e) =>
    e.preventDefault()
    if @formIsValid()
      # submit
    else
      # show error message

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
