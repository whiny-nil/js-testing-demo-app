#= require features/example

describe "Example", ->
  describe "#notFalse", ->
    it "is true", ->
      eg = new Example
      expect(eg.notFalse()).to.be.true
