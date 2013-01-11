App.namespace 'App.Views.Forum.Boards', (ns)->
        class ns.Show extends Backbone.View

                template: JST['templates/forum/boards/show']

                tagName:'div'
                className:'board-item'

                events:
                    "click #edit":"edit"
                    "click #cancel":"toggleInputs"                
                    "click #ok":"submit"
                    "keyup input":"submit"   
                

                initialize: (options) ->
                        _.bindAll @
                        @listenTo(@model, 'sync', @render);
                        @$el.addClass options['classTag']
                        @render()
                        
                render: ->
                        @$el.html @template({model:@model.toJSON()})
                        @
                        
                edit:->
                        @toggleInputs()

                submit:(event)->
                        switch event.type
                                when 'click'
                                        @update()
                                when 'keyup'
                                        switch event.keyCode
                                                when 13
                                                        @update()                                                
                                                when 27
                                                        @toggleInputs()
                update:->
                        @model.set
                                name:@$el.find('input#board-name').val()
                                description:@$el.find('input#board-description').val()
                        @model.save()
                        @model.fetch()                        
                                                                
                toggleInputs:->
                        @$el.find('input#board-name, 
                                input#board-description,
                                a#ok,
                                a#cancel,
                                a#board-name,
                                span#board-description,
                                a#edit').toggleClass('hide')

                        

                                        
