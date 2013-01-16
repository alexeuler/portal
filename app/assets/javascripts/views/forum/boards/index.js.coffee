App.namespace 'App.Views.Forum.Boards', (ns)->
        class ns.Index extends Backbone.View

                tagName:'div'
                className:'boards'


                initialize: ->
                        _.bindAll @
                        @views=[]
                        @listenTo(@collection, 'sync', @reset)

                reset:->
                        @clear()
                        @views.push new App.Views.Forum.Boards.New()
                        @views[0].on 'boards.add',@add
                        currentGroup=id:-1
                        for model,i in @collection.models
                                unless (extracted=@extractGroup(i)).id is currentGroup.id
                                        currentGroup=extracted
                                        groupView=new App.Views.Forum.Groups.Show model:new App.Models.BoardGroup(extracted)
                                        @views.push groupView
                                        
                                view=new App.Views.Forum.Boards.Show model:model                                        
                                groupView.views.push view           
                        @render()
                        
                render: ->
                        @$el.empty()
                        for view in @views
                                @$el.append view.render().$el
                        @

                new:(e)->
                        @views[0].toggle()
                                                
        
                add:(view)->
                        @collection.fetch()
                                                                        
                clear:->
                        for view in @views
                                view.remove()
                        @views=[]

                remove:->
                        @clear()
                        super
                                
                extractGroup:(model_number)->
                        @collection.models[model_number]?.get('board_group')
                        
