
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

module.exports = helpers
