class App.Routers.Boards extends Backbone.Router
        routes:
                "forum/boards/:id": "show"
                "forum/boards": "index"
                
        initialize:(options)->
                @display=options?['display']
        
        show: (id) ->
                window.view?.remove()
                model=new App.Models.Board id:id
                model.fetch success: =>
                        window.view=new App.Views.Board model:model
                        @display.append window.view.render().$el

        index:->
                window.view?.remove()                
                window.view=new App.Views.Boards 