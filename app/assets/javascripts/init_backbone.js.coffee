Backbone.Models={}
Backbone.Collections={}
Backbone.Views={}
Backbone.Routers={}

$ ->
        $('body').append "<div class='view'></div>"
        view=new Backbone.Views.Boards
