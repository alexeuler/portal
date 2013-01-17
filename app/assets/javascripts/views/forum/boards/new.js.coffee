App.namespace 'App.Views.Forum.Boards', (ns)->
        class ns.New extends Backbone.View

                template: JST['templates/forum/boards/new']

                tagName:'div'
                className:'board-item-new'

                events:
                        "click":"contain"
                        "click #new":"toggle"                        
                        "click #cancel":"toggle"                
                        "click #ok":"submit"
                        "keyup input":"submit"   

                
                initialize: (options) ->
                        @groupPreview=new App.Views.Forum.Groups.Show model:new App.Models.BoardGroup()
                        @boardPreview=new App.Views.Forum.Boards.Show model:new App.Models.Board()
                        @groupPreview.render().$el.find('.board-group-item-controls').addClass('hide')
                        @boardPreview.render().$el.find('.board-item-controls').addClass('hide')

                                                
                render: ->
                        @$el.html @template()
                        @$el.find('.board-group-item-preview').html @groupPreview.$el
                        @$el.find('.board-item-preview').html @boardPreview.$el                        
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
                                                        @boardPreview.model.set
                                                                name:@$el.find('.new-inputs input#board-name').val()
                                                                description:@$el.find('.new-inputs input#board-description').val()
                                                        @groupPreview.model.set name:@$el.find('.new-inputs input#board-group').val()
                create:->
                        @boardPreview.model.set
                                name:@$el.find('.new-inputs input#board-name').val()
                                description:@$el.find('.new-inputs input#board-description').val()
                                board_group:
                                        name:@$el.find('.new-inputs #board-group').val()
                        @trigger 'collection.add', @boardPreview.model
                                                                
                toggle:->
                        @$el.children().toggleClass('hide')

                        

                                        
