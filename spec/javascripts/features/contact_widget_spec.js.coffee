#= require jquery
#= require features/contact_widget/contact_widget_template
#= require features/contact_widget/contact_widget

describe "ContactWidget", ->
  describe "toggleBtn", ->
    describe "click", ->
      it "shows the contact form if hidden", ->
        widget = new ContactWidget('#konacha')
        widget.$form.hide()

        widget.$toggleBtn.click()
        expect(widget.$form.css('display')).not.to.equal('none')

      it "hides the contact form if shown"
