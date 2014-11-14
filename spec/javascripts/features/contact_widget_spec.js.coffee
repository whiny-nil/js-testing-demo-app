#= require jquery
#= require sinon
#= require sinon-chai
#= require features/contact_widget/contact_widget_template
#= require features/contact_widget/contact_widget

describe "ContactWidget", ->
  beforeEach ->
    @widget = new ContactWidget('#konacha')

  describe "$toggleBtn", ->
    describe "click event", ->
      it "calls @toggleForm()", ->
        # don't use @widget, need to fuck with the prototype to install the
        # spy before construction
        toggleSpy = sinon.spy(ContactWidget.prototype, 'toggleForm')
        widget = new ContactWidget('#konacha')
        widget.$toggleBtn.click()
        expect(toggleSpy.called).to.be.true

    describe "@toggleForm()", ->
      it "shows the contact form if hidden", ->
        @widget.toggleForm()
        expect(@widget.$form.css('display')).not.to.equal('none')

      it "hides the contact form if shown", ->
        @widget.$form.show()
        @widget.toggleForm()
        expect(@widget.$form.css('display')).to.equal('none')



  describe "$form", ->
    it "should be hidden when the widget is instantiated", ->
      expect(@widget.$form.css('display')).to.equal('none')



  describe "$submitBtn", ->
    describe "click event", ->
      it "calls @processForm()", ->
        # don't use @widget, need to fuck with the prototype to install the
        # spy before construction
        processSpy = sinon.spy(ContactWidget.prototype, 'processForm')
        widget = new ContactWidget('#konacha')
        widget.$submitBtn.click()
        expect(processSpy.called).to.be.true



  describe "@processForm()", ->
    it "stops the default action (form submission)", ->
      e = { preventDefault: sinon.spy() }
      @widget.processForm(e)
      expect(e.preventDefault.called).to.be.true

    it "validates the form data", ->
      @widget.formIsValid = sinon.spy()
      e = { preventDefault: sinon.spy()}
      @widget.processForm(e)
      expect(@widget.formIsValid.called).to.be.true

    it "submits the form data to the server", ->
      @widget.formIsValid = -> true
      @widget.submitForm = sinon.spy()
      e = { preventDefault: sinon.spy()}
      @widget.processForm(e)
      expect(@widget.submitForm.called).to.be.true



  describe "@formIsValid()", ->
    it "checks that the email is valid", ->
      @widget.emailValidator = sinon.spy()
      @widget.formIsValid()
      expect(@widget.emailValidator.called).to.be.true

    it "checks that the message is valid", ->
      @widget.messageValidator = sinon.spy()
      @widget.formIsValid()
      expect(@widget.messageValidator.called).to.be.true

    it "returns true if the form is valid", ->
      @widget.$emailField.val('test@example.com')
      @widget.$messageField.val('message')
      expect(@widget.formIsValid()).to.be.true

    it "returns false if the form is invalid", ->
      expect(@widget.formIsValid()).to.be.false



  describe "@submitForm()", ->
    it "POSTs the form data", ->
      xhr = sinon.useFakeXMLHttpRequest()
      requests = []
      xhr.onCreate = (req) -> requests.push(req)

      @widget.$emailField.val('test@example.com')
      @widget.$messageField.val('message')
      @widget.submitForm()

      expect(requests[0].method).to.equal("POST")

      xhr.restore()

    it "sends the data to /contact/create", ->
      xhr = sinon.useFakeXMLHttpRequest()
      requests = []
      xhr.onCreate = (req) -> requests.push(req)

      @widget.$emailField.val('test@example.com')
      @widget.$messageField.val('message')
      @widget.submitForm()

      expect(requests[0].url).to.equal("/contact/create")

      xhr.restore()

    it "submits email and message", ->
      xhr = sinon.useFakeXMLHttpRequest()
      requests = []
      xhr.onCreate = (req) -> requests.push(req)

      @widget.$emailField.val('test@example.com')
      @widget.$messageField.val('message')
      @widget.submitForm()

      expect(requests[0].requestBody).to.match(/email=/)
      expect(requests[0].requestBody).to.match(/message=/)

      xhr.restore()

    it "shows a warning message if the request fails", ->
      server = sinon.fakeServer.create()
      server.respondWith "POST",
        "/contact/create",
        [
          404,
          { "Content-Type": "application/json" },
          '{ "status": "OK", "message": "Fake server" }'
        ]

      @widget.showWarning = sinon.spy()
      @widget.$emailField.val('test@example.com')
      @widget.$messageField.val('message')
      @widget.submitForm()
      server.respond() # don't respond...

      expect(@widget.showWarning.calledWith("An error occured")).to.be.true

      server.restore()

    it "handles the response if the request is successful", ->
      server = sinon.fakeServer.create()
      server.respondWith "POST",
        "/contact/create",
        [
          200,
          { "Content-Type": "application/json" },
          '{ "status": "OK", "message": "Fake server" }'
        ]

      @widget.successHandler = sinon.spy()
      @widget.$emailField.val('test@example.com')
      @widget.$messageField.val('message')
      @widget.submitForm()
      server.respond()
      expect(@widget.successHandler.called).to.be.true

      server.restore()



  describe "@successHandler()", ->
    it "shows a notification if the request succeeds and the server responds with 'success'", ->
      @widget.showNotice = sinon.spy()
      @widget.successHandler {status: "OK", message: "It worked"}
      expect(@widget.showNotice.calledWith("It worked")).to.be.true

    it "shows a warning if the request succeeds but the server responds with 'failure'", ->
      @widget.showWarning = sinon.spy()
      @widget.successHandler {status: "Failed", message: "It didn't work"}
      expect(@widget.showWarning.calledWith("It didn't work")).to.be.true



  describe "@emailValidator()", ->
    it "checks that the email is not empty", ->
      @widget.emailValidator()
      expect(@widget.valid).to.be.false
      expect(@widget.errors).to.include('Email cannot be blank')



  describe "@messageValidator()", ->
    it "checks that the message is not empty", ->
      @widget.messageValidator()
      expect(@widget.valid).to.be.false
      expect(@widget.errors).to.include('Message cannot be blank')



  describe "@showNotice()", ->
    it "renders the supplied message in the message box"
    it "makes the message box look like a notice"
    it "shows the message box"


  describe "@showWarning()", ->
    it "renders the supplied message in the message box"
    it "makes the message box look like a warning"
    it "shows the message box"
