window.App=
        Models: {}
        Collections: {}
        Views: {}
        Routers: {}
        Initialize: ->
                $('body').append "<div class='display'></div>"
                $('body').on 'click', 'a', (e)->
                        e.preventDefault()
                        href = $(e.currentTarget).attr('href')
                        Backbone.history.navigate href, trigger:true
                        
                $('.display').append "<a href='/forum/boards'>Boards</a>"
                new App.Routers.Boards display:$('.display')
                Backbone.history.start({pushState:true})
                
$ ->
        App.Initialize()