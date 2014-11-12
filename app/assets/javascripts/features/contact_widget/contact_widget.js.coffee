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
    @$toggleBtn = @$widget.children('.toggle-btn')
    @$form = @$widget.children('.form')

  setupEvents: =>
    @$toggleBtn.on 'click', =>
      @$form.toggle()
