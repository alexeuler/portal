class App.Views.Group extends Backbone.View

        tagName:'div'
        className:'board_group'

        initialize: (options) ->
                _.bindAll @
                @render()
                
        render: ->
                @$el.html @model.name            
                
