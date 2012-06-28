
assert     = require 'assert'
Pie        = require '../../models/pie.coffee'



describe 'Pie', ->
  describe "create", ->
    pie = null
    before ->
      pie = new Pie {name:'Key Lime'}
      
    it "sets name"
    it "defaults to some state"
    it "generates Id"
