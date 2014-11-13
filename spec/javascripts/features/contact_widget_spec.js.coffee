#= require jquery
#= require sinon
#= require sinon-chai
#= require features/contact_widget/contact_widget_template
#= require features/contact_widget/contact_widget

describe "ContactWidget", ->
  describe "$toggleBtn", ->
    describe "click event", ->
      it "calls @toggleForm()", ->
        toggleSpy = sinon.spy(ContactWidget.prototype, 'toggleForm')
        widget = new ContactWidget('#konacha')
        #widget.toggleForm = sinon.spy()
        widget.$toggleBtn.click()
        expect(toggleSpy.called).to.be.true

    describe "@toggleForm()", ->
      it "shows the contact form if hidden", ->
        widget = new ContactWidget('#konacha')
        widget.toggleForm()
        expect(widget.$form.css('display')).not.to.equal('none')

      it "hides the contact form if shown", ->
        widget = new ContactWidget('#konacha')
        widget.$form.show()
        widget.toggleForm()
        expect(widget.$form.css('display')).to.equal('none')

  describe "$form", ->
    it "should be hidden when the widget is instantiated", ->
      widget = new ContactWidget('#konacha')
      expect(widget.$form.css('display')).to.equal('none')

  describe "$submitBtn", ->
    describe "click event", ->
      it "calls @processForm()", ->
        processSpy = sinon.spy(ContactWidget.prototype, 'processForm')
        widget = new ContactWidget('#konacha')
        widget.$submitBtn.click()
        expect(processSpy.called).to.be.true

  describe "@processForm()", ->
      it "stops the default action (form submission)", ->
        widget = new ContactWidget('#konacha')
        e = { preventDefault: sinon.spy() }
        widget.processForm(e)
        expect(e.preventDefault.called).to.be.true

      it "validates the form data", ->
        widget = new ContactWidget('#konacha')
        widget.formIsValid = sinon.spy()
        e = { preventDefault: sinon.spy()}
        widget.processForm(e)
        expect(widget.formIsValid.called).to.be.true

      it "submits the form data to the server"

  describe "@formIsValid()", ->
    it "checks that the email is valid", ->
      widget = new ContactWidget('#konacha')
      widget.emailValidator = sinon.spy()
      widget.formIsValid()
      expect(widget.emailValidator.called).to.be.true

    it "checks that the message is valid", ->
      widget = new ContactWidget('#konacha')
      widget.messageValidator = sinon.spy()
      widget.formIsValid()
      expect(widget.messageValidator.called).to.be.true

    it "returns true if the form is valid", ->
      widget = new ContactWidget('#konacha')
      widget.$emailField.val('test@example.com')
      widget.$messageField.val('message')
      expect(widget.formIsValid()).to.be.true

    it "returns false if the form is invalid", ->
      widget = new ContactWidget('#konacha')
      expect(widget.formIsValid()).to.be.false

  describe "@emailValidator()", ->
    it "checks that the email is not empty", ->
      widget = new ContactWidget('#konacha')
      widget.emailValidator()
      expect(widget.valid).to.be.false
      expect(widget.errors).to.include('Email cannot be blank')

  describe "@messageValidator()", ->
    it "checks that the message is not empty", ->
      widget = new ContactWidget('#konacha')
      widget.messageValidator()
      expect(widget.valid).to.be.false
      expect(widget.errors).to.include('Message cannot be blank')

