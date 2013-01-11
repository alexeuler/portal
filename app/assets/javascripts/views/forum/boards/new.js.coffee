App.namespace 'App.Views.Forum.Boards', (ns)->
        class ns.New extends Backbone.View

                template: JST['templates/forum/boards/new']

                tagName:'div'
                className:'board-item even first last'

                events:
                        "click .board-item-inputs":"contain"
                        "click #cancel":"remove"                
                        "click #ok":"submit"
                        "keyup input":"submit"   
                

                initialize: (options) ->
                        _.bindAll @
                        @board=options?.board
                        @group=options?.group                        
                        @render()
                        
                render: ->
                        @$el.html @template()
                        @

                contain:(event)->
                        event.preventDefault()
                        event.stopPropagation()
                        
                submit:(event)->
                        switch event.type
                                when 'click'
                                        @create()
                                when 'keyup'
                                        switch event.keyCode
                                                when 13
                                                        @create()                                                
                                                when 27
                                                        @remove()
                                                else
                                                        @board.set
                                                                name:@$el.find('#board-name').val()
                                                                description:@$el.find('#board-description').val()
                                                        @group.set name:@$el.find('#board-group').val()
                create:->
                        @model.set
                                name:@$el.find('input#board-name').val()
                                description:@$el.find('input#board-description').val()
                                board_group:@$el.find('input#board-group').val()
                        @model.save()
                                                                
                toggleEdit:->
                        @$el
                        .find('.board-item-show, .board-item-inputs, .board-item-controls')
                        .toggleClass('hide')

                        

                                        
