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
                        currentGroupModel=new App.Models.BoardGroup id:-1
                        for model,i in @collection.models
                                unless model.group.get('id') is currentGroupModel.get('id')
                                        currentGroupModel=model.group
                                        groupView=new App.Views.Forum.Groups.Show model:currentGroupModel
                                        @views.push groupView
                                view=new App.Views.Forum.Boards.Show model:model
                                view.on 'boards.destroy', @destroy
                                groupView.views.push view           
                        @render()
                        
                render: ->
                        @$el.empty()
                        for view in @views
                                @$el.append view.render().$el
                        @

                add:(view)->
                        @collection.fetch()

                destroy:(view)->
                        @collection.remove(view.model)
                        id=view.model.group.get('id')
                        boards=@collection.select (model)->
                                model.group.get('id') is id
                        if boards.length is 0
                                new App.Models.BoardGroup({id:id}).destroy()
                                groupView=_.find @views, (_view)=>
                                        _view.model?.get('id') is id
                                groupView.remove()
                                @views=_.without @views, groupView

                clear:->
                        for view in @views
                                view.remove()
                        @views=[]

                remove:->
                        @clear()
                        super
                               
