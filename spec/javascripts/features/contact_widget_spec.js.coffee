#= require jquery
#= require sinon
#= require features/contact_widget/contact_widget_template
#= require features/contact_widget/contact_widget

describe "ContactWidget", ->
  describe "toggleBtn", ->
    describe "click", ->
      it "shows the contact form if hidden", ->
        widget = new ContactWidget('#konacha')
        widget.$toggleBtn.click()
        expect(widget.$form.css('display')).not.to.equal('none')

      it "hides the contact form if shown", ->
        widget = new ContactWidget('#konacha')
        widget.$form.show()
        widget.$toggleBtn.click()
        expect(widget.$form.css('display')).to.equal('none')

  describe "form", ->
    it "should be hidden when the widget is instantiated", ->
      widget = new ContactWidget('#konacha')
      expect(widget.$form.css('display')).to.equal('none')

  describe "submitBtn", ->
    describe "click", ->
      it "calls @processForm", ->
        widget = new ContactWidget('#konacha')
        widget.processForm = sinon.spy()
        widget.$submitBtn.click()
        expect(widget.processForm).to.have.been.called

  describe "@processForm", ->
      it "stops the default action (form submission)", ->
        widget = new ContactWidget('#konacha')
        e = {}
        e.preventDefault = sinon.spy()
        widget.processForm(e)
        expect(e.preventDefault).to.have.been.called

      it "validates the form data"
      it "submits the form data to the server"

