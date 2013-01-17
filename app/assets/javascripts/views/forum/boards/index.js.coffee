App.namespace 'App.Views.Forum.Boards', (ns)->
        class ns.Index extends Backbone.View

                tagName:'div'
                className:'boards'


                initialize: ->
                        _.bindAll @
                        @views=[]
                        @listenTo(@collection, 'sync', @reset)
                        @listenTo(@collection, 'add', @add)
                        @listenTo(@collection, 'remove', @destroy)
                reset:->
                        @clear()
                        @views.push new App.Views.Forum.Boards.New()
                        @views[0].on 'collection.add',@addModel
                        currentGroupModel=new App.Models.BoardGroup id:-1
                        for model,i in @collection.models
                                unless model.group.get('id') is currentGroupModel.get('id')
                                        currentGroupModel=model.group
                                        groupView=new App.Views.Forum.Groups.Show model:currentGroupModel
                                        @views.push groupView
                                view=new App.Views.Forum.Boards.Show model:model
                                view.on 'collection.destroy', @destroyModel
                                groupView.views.push view           
                        @render()
                        
                render: ->
                        @$el.empty()
                        for view in @views
                                @$el.append view.render().$el
                        @

                add:(model, collection, options)->
                        @collection.fetch()

                destroy:(model, collection, options)->
                        groupID=model.group.get('id')
                        ID=model.get('id')
                        groupView=_.find @views, (_view)->
                                _view.model?.get('id') is groupID
                        boardView=_.find groupView.views, (_view)->
                                _view.model?.get('id') is ID
                        boardView.remove()
                        groupView.views=_.without groupView.views, boardView                        
                        boards=collection.select (_model)->
                                _model.group.get('id') is groupID
                        if boards.length is 0
                                groupView.remove()
                                @views=_.without @views, groupView

                addModel:(model)->
                        model.save()
                        @collection.add(model)

                destroyModel:(model)->
                        model.destroy()
                        @collection.remove(model)

                clear:->
                        for view in @views
                                view.remove()
                        @views=[]

                remove:->
                        @clear()
                        super
                               
