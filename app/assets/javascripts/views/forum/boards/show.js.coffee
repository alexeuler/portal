App.namespace 'App.Views.Forum.Boards', (ns)->
        class ns.Show extends Backbone.View

                template: JST['templates/forum/boards/show']

                tagName:'div'
                className:'board-item'

                initialize: (options) ->
                        _.bindAll @
                        @listenTo(@model, 'change', @render);
                        @$el.addClass options['classTag']
                        @render()
                        
                render: ->
                        @$el.html @template({model:@model.toJSON()})
                        @
                        
