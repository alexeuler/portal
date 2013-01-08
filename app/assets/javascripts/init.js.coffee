window.App=
        Models: {}
        Collections: {}
        Views: {}
        Routers: {}
        Initialize: ->
                @view=new @Views.App
                $('body').on 'click', 'a', (e)->
                        e.preventDefault()
                        href = $(e.currentTarget).attr('href')
                        Backbone.history.navigate href, trigger:true
                new App.Routers.Boards display:@view.$el.find('.display')
                Backbone.history.start({pushState:true})
                
$ ->
        App.Initialize()