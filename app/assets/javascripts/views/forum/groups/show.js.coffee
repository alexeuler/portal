App.namespace 'App.Views.Forum.Groups', (ns)->
        class ns.Show extends Backbone.View

                tagName:'div'
                className:'board_group'

                initialize: (options) ->
                        _.bindAll @
                        @render()
                        
                render: ->
                        @$el.html @model.name            
                        
