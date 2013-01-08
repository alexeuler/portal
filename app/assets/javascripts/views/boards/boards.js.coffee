class App.Views.Boards extends Backbone.View

        tagName:'div'
        className:'boards'

        views:[]

        initialize: ->
                _.bindAll @
                @collection=new App.Collections.Boards()
                @listenTo(@collection, 'sync', @reset);                
                @collection.fetch()

        reset:->
                @clear()
                currentGroupName=''
                groupIteraror=0
                for model,i in @collection.models
                        groupIteraror++                        
                        unless @getGroupName(i) is currentGroupName
                                groupIteraror=1
                                currentGroupName=@getGroupName(i)                                
                                groupView=new App.Views.Group model:{name:currentGroupName}
                                @views.push groupView
                                @$el.append groupView.$el
                                
                        view=new App.Views.Board model:model, classTag: @makeClassTag(groupIteraror, not(currentGroupName is @getGroupName(i+1)))
                        @views.push view                
                @render()
                                                
        render: ->
                for view in @views
                        @$el.append view.$el
                @
                
        clear:->
                for view in @views
                        view.remove()
                @views=[]

        remove:->
                @clear()
                super
                        
        getGroupName:(model_number)->
                @collection.models[model_number]?.get('board_group')?.name
                
        makeClassTag:(iterator, last)->
                classTag=''
                if iterator is 1 then classTag+='first '
                if iterator%2 is 0 then classTag+='odd '                        
                if iterator%2 is 1 then classTag+='even '
                if last then classTag+='last '
                classTag
                