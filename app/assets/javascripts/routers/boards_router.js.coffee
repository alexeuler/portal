class App.Routers.Boards extends Backbone.Router
        routes:
                "forum/boards/:id": "show"
                "forum/boards": "index"
                
        initialize:(options)->
                @display=options?['display']
        
        show: (id) ->
                @clearDisplay()                
                model=new App.Models.Board id:id
                model.fetch success: =>
                        @display.view=new App.Views.Board model:model
                        @display.append @display.view.$el

        index:->
                @clearDisplay()
                @display.view=new App.Views.Boards
                @display.append @display.view.$el

        clearDisplay:->
                @display.view?.remove()                