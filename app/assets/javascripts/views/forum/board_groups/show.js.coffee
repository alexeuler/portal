App.namespace 'App.Views.Forum.Groups', (ns)->
        class ns.Show extends Backbone.View

                template:JST['templates/forum/board_groups/show']

                events:
                        "click .board-group-item-inputs, .board-group-item-controls":"contain"
                        "click #edit":"toggleEdit"
                        "click #cancel":"toggleEdit"                
                        "click #ok":"submit"
                        "keyup input":"submit"   

                tagName:'div'
                className:'board-group'

                initialize: (options) ->
                        @views=[]                        
                        @listenTo(@model, 'change', @change)
                        @listenTo(@model, 'sync', @render)                                         
                render: ->
                        @$el.html(@template model:@model.toJSON())
                        @$el.find('.board-group-boards').append view.render().$el for view in @views
                        @
                                
                change:(model, options)->                        
                        if model.changed.name?
                                @$el.find('.board-group-item-show').text(model.changed.name)

                contain:(event)->
                        event.preventDefault()
                        event.stopPropagation()

                submit:(event)->
                        switch event.type
                                when 'click'
                                        @update()
                                when 'keyup'
                                        switch event.keyCode
                                                when 13
                                                        @update()                                                
                                                when 27
                                                        @toggleEdit()
                update:->
                        @model.set
                                name:@$el.find('input#board-group-name').val()
                        @model.save()
                        @model.fetch()                        

                toggleEdit:->
                        @$el
                        .find('.board-group-item-show, .board-group-item-inputs, .board-group-item-controls')
                        .toggleClass('hide')
                        
                remove:->
                        view.remove() for view in @views
                        @views=[]
