class App.Routers.Boards extends Backbone.Router
        routes:
                "forum/boards/:id": "show"
                "forum": "index"
                "forum(/:subsection)": "index"                
                
        initialize:(options)->
                @display=options?['display']
        
        show: (id) ->
                @clearDisplay()                
                model=new App.Models.Board id:id
                @display.view=new App.Views.Forum.Boards.Show model:model
                @display.append @display.view.$el
                model.fetch()                                                        


        index:->
                @clearDisplay()
                collection=new App.Collections.Boards()                
                @display.view=new App.Views.Forum.Boards.Index collection:collection
                @display.append @display.view.$el
                collection.fetch()                

        clearDisplay:->
                @display.view?.remove()                