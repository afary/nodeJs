Pie = require '../../models/pie'

routes = (app) ->
  app.namespace '/admin', ->

    # Authentication check
    app.all '/*', (req, res, next) ->
      if not (req.session.currentUser)
        req.flash 'error', 'Please login.'
        res.redirect '/login'
        return
      next()

    app.get '/', (req, res) ->
      res.redirect '/admin/menu/stage'

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
        pie.save (err, pie) ->
          req.flash 'info', "Pie '#{pie.name}' was saved."
          res.redirect '/admin/pies'
      
      app.put '/:id', (req, res) ->
        Pie.getById req.params.id, (err, pie) ->
          if req.body.state in Pie.states
            pie[req.body.state] ->
              if socketIO = app.settings.socketIO
                socketIO.sockets.emit "pie:changed", pie
               res.send "OK"
    app.namespace '/menu', ->

      app.get '/stage', (req, res) ->
        Pie.all (err, pies) ->
          res.render "#{__dirname}/views/menu/stage",
            title: 'Pie Status'
            stylesheet: 'admin'
            pies: pies      

module.exports = routes
