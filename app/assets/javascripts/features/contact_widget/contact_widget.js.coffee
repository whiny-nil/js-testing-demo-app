class @ContactWidget
  constructor: (container) ->
    @template = JST['features/contact_widget/contact_widget_template']({})
    @$container = $(container)
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
    @emailValidator()
    # some stuff
    #
  emailValidator: =>
    'here'
