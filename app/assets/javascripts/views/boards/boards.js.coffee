class Backbone.Views.Boards extends Backbone.View

        el: '.view'

        views:[]

        initialize: ->
                _.bindAll @
                @collection=new Backbone.Collections.Boards()
                @collection.fetch success:@render
                
        render: ->
                currentGroupName=''
                groupIteraror=0
                for model,i in @collection.models
                        groupIteraror++                        
                        unless @getGroupName(i) is currentGroupName
                                groupIteraror=1
                                currentGroupName=@getGroupName(i)                                
                                groupView=new Backbone.Views.Group model:{name:currentGroupName}
                                @views.push groupView
                                @$el.append groupView.$el
                                
                        view=new Backbone.Views.Board model:model, classTag: @makeClassTag(groupIteraror, not(currentGroupName is @getGroupName(i+1)))
                        @$el.append view.$el
                        @views.push view
                @
                
        remove:->
                for view in @views
                        view.remove()
                        
        getGroupName:(model_number)->
                @collection.models[model_number]?.get('board_group')?.name
                
        makeClassTag:(iterator, last)->
                classTag=''
                if iterator is 1 then classTag+='first '
                if iterator%2 is 0 then classTag+='odd '                        
                if iterator%2 is 1 then classTag+='even '
                if last then classTag+='last '
                classTag
                