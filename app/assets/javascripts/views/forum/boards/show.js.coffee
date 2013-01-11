App.namespace 'App.Views.Forum.Boards', (ns)->
        class ns.Show extends Backbone.View

                template: JST['templates/forum/boards/show']

                tagName:'div'
                className:'board-item'

                events:
                        "click .board-item-inputs, .board-item-controls":"contain"
                        "click #edit":"toggleEdit"
                        "click #cancel":"toggleEdit"                
                        "click #ok":"submit"
                        "keyup input":"submit"   
                

                initialize: (options) ->
                        _.bindAll @
                        @listenTo(@model, 'sync', @render);
                        @listenTo(@model, 'change', @change);                        
                        @$el.addClass options?['classTag']
                        @render()
                        
                render: ->
                        @$el.html @template({model:@model.toJSON()})
                        @

                change:(model, options)->
                        for key,value of model.changed
                                switch key
                                        when 'name'
                                                @$el.find('input#board-name').val(value)
                                                @$el.find('a#board-name').text(value)
                                        when 'description'
                                                @$el.find('input#board-description').val(value)
                                                @$el.find('span#board-description').text(value)                      
                        
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
                                name:@$el.find('input#board-name').val()
                                description:@$el.find('input#board-description').val()
                        @model.save()
                        @model.fetch()                        
                                                                
                toggleEdit:->
                        @$el
                        .find('.board-item-show, .board-item-inputs, .board-item-controls')
                        .toggleClass('hide')

                        

                                        
