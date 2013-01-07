class Backbone.Routers.Boards extends Backbone.Router
        routes:
                "forum/boards/:id": "show"
                "forum/boards": "index"
                
        show: (id) ->
                window.view?.remove()
                model=new Backbone.Models.Board id:id
                model.fetch success: ->
                        window.view=new Backbone.Views.Board model:model
                        $('.view').append window.view.render().$el

        index:->
                window.view?.remove()                
                window.view=new Backbone.Views.Boards 