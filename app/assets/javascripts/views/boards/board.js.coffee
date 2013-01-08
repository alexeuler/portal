class App.Views.Board extends Backbone.View

        template: JST['forum/boards/board']

        tagName:'div'
        className:'board_item'

        initialize: (options) ->
                _.bindAll @
                @$el.addClass options['classTag']
                @render()
                
        render: ->
                @$el.html @template({model:@model.toJSON()})
                @
                
