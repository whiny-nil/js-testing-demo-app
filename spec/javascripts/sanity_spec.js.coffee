class Sanity
  constructor: ->
    @sane = true

  sanity: ->
    @sane

describe "sanity", ->
  it "is sane", ->
    sanity = new Sanity
    sanity.sane.should.be
