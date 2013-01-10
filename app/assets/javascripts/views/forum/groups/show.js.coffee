App.namespace 'App.Views.Forum.Groups', (ns)->
        class ns.Show extends Backbone.View

                tagName:'div'
                className:'board-group-item'

                initialize: (options) ->
                        _.bindAll @
                        @render()
                        
                render: ->
                        @$el.html @model.name            
                        
