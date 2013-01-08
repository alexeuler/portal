window.App=
        Models: {}
        Collections: {}
        Views: {}
        Routers: {}
        Initialize: ->
                $('body').append "<div class='view'></div>"
                $('body').on 'click', 'a', (e)->
                        e.preventDefault()
                        href = $(e.currentTarget).attr('href')
                        Backbone.history.navigate href, trigger:true
                        
                $('.view').append "<a href='/forum/boards'>Boards</a>"
                new App.Routers.Boards display:$('.view')
                Backbone.history.start({pushState:true})
                
$ ->
        App.Initialize()