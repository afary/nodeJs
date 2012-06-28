Pie = require '../../models/pie'

routes = (app) ->
  app.namespace '/admin', ->


    app.namespace '/pies', ->
      
      # List all pies.
      app.get '/', (req, res) ->
        pie = new Pie {}
        Pie.all (err, pies) ->
          res.render "#{__dirname}/views/pies/all",
            title: 'View All Pies'
            stylesheet: 'admin'
            pie: pie
            pies: pies
      
       # Create a pie.
      app.post '/', (req, res) ->
        attributes =
          name: req.body.name
          type: req.body.type
        pie = new Pie attributes
        pie.save () ->
          req.flash 'info', "Pie '#{pie.name}' was saved."
          res.redirect '/admin/pies'

module.exports = routes
