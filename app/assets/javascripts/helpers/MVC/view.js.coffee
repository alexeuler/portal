App.namespace 'App.MVC', (ns)->
        class ns.View extends Backbone.View
                children: []
                container:''
                parent:null
                sort:''
                iterator:null
                
                constructor: (options)->
                        for name in ['parent', 'sort', 'children', 'container','iterator']
                                @[name]=App.ExtractOptions(options, name)||@[name]
                        super(options)

                forEach:  (func, order)->
                        _iterator=iterator||new App.Iterator list:@children, sort:@sort
                        _iterator.forEach (child)->
                                unless order is 'post' func(child)
                                child.forEach(func)
                                if order is 'post' func(child)

                forEachChild: (func)->
                        _iterator=iterator||new App.Iterator list:@children, sort:@sort
                        _iterator.forEach(func)

                renderSelf: ->
                        if @template
                                @$el.html(@template model:@model.toJSON())
                        else
                                @$el.empty()

                render: ->
                        @renderSelf()
                        @forEachChild (child)=>
                                child.render()
                                @$el.find(child.container).append child.$el
                                                
                addChild: (options)->

                find: (field)->

                findChild: (field)->

                remove: ->
                        super
                        @unbind()
                        @deleteChildren()
                        @removeFromParent()