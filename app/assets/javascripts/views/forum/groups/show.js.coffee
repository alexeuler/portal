App.namespace 'App.Views.Forum.Groups', (ns)->
        class ns.Show extends Backbone.View

                tagName:'div'
                className:'board-group-item'

                initialize: (options) ->
                        _.bindAll @
                        @listenTo(@model, 'change', @change)
                        @render()
                        
                render: ->
                        @$el.html @model.get('name')
                        
                change:(model, options)->                        
                        if model.changed.name?
                                @$el.text(model.changed.name)