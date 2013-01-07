Backbone.Models={}
Backbone.Collections={}
Backbone.Views={}
Backbone.Routers={}

$ ->
        $('body').append "<div class='view'></div>"
        $('.view').append "<a href='#/forum/boards'>Boards</a>"
        new Backbone.Routers.Boards()

        Backbone.history.start()
