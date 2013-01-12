App.namespace 'App.Views.Forum.Boards', (ns)->
        class ns.Index extends Backbone.View

                tagName:'div'
                className:'boards'

                events:
                        "click #new":"new"

                views:[]

                initialize: ->
                        _.bindAll @
                        @listenTo(@collection, 'sync', @reset)
                        @reset()              

                reset:->
                        @clear()
                        currentGroup=id:-1
                        groupIteraror=0
                        for model,i in @collection.models
                                groupIteraror++                        
                                unless (extracted=@extractGroup(i)).id is currentGroup.id
                                        currentGroup=extracted                                
                                        groupIteraror=1
                                        groupView=new App.Views.Forum.Groups.Show model:new App.Models.BoardGroup(extracted)
                                        @views.push groupView
                                        
                                view=new App.Views.Forum.Boards.Show
                                        model:model,
                                        classTag: @makeClassTag(groupIteraror, not(currentGroup is @extractGroup(i+1)))
                                @views.push view                
                        @render()

                                                        
                render: ->
                        @$el.empty()
                        @$el.append '<a id="new" href="">Создать</a>'                        
                        for view in @views
                                @$el.append view.$el
                        @

                new:(e)->
                        e.preventDefault()
                        e.stopPropagation()
                        board=new App.Models.Board()
                        group=new App.Models.Group()
                        @views.unshift(new App.Views.Forum.Groups.Show model:group)
                        @views.unshift(new App.Views.Forum.Boards.Show model:board, classTag:'even')
                        @views.unshift(new App.Views.Forum.Boards.New board:board, group:group)
                        @views[1].$el.find('.board-item-controls').addClass('hide')
                        @$el.prepend @views[i].$el for i in [0..2]
        
                add:->

                                                                        
                clear:->
                        for view in @views
                                view.remove()
                        @views=[]

                remove:->
                        @clear()
                        super
                                
                extractGroup:(model_number)->
                        @collection.models[model_number]?.get('board_group')
                        
                makeClassTag:(iterator, last)->
                        classTag=''
                        if iterator is 1 then classTag+='first '
                        if iterator%2 is 0 then classTag+='odd '                        
                        if iterator%2 is 1 then classTag+='even '
                        if last then classTag+='last '
                        classTag
                        