
helpers = (app) ->
  app.dynamicHelpers
    flash: (req, res) ->
      req.flash()
  app.helpers
    urlFor: (obj) ->
      if obj.id
        "/admin/pies/#{obj.id}"
      else
        "/admin/pies"
    cssClassForState: (expected, actual) ->
      if actual is expected
        [expected, 'on']
      else
        expected





module.exports = helpers
