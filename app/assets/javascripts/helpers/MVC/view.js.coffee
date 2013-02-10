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
                                func(child) unless order is 'post' 
                                child.forEach(func)
                                func(child) if order is 'post' 

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
                        sortOnAdd=App.ExtractOptions options, 'sortOnAdd'
                        renderOnAdd=App.ExtractOptions options, 'renderOnAdd'
                        options=_.defaults options || {}, parent:@
                        child=new App.MVC.View(options)
                        @children.push child
                        child.render() if renderOnAdd
                        if sortOnAdd
                                #extract all children in the same container
                                # find insert position
                                # append
                                @$el.find(child.container).append child.$el

                find: (field, value)->
                        result
                        extractor=new App.FieldExtractor field
                        @forEach (child)->
                                if extractor child is value then result=child
                        
                findChild: (field)->

                remove: ->
                        super
                        @unbind()
                        @deleteChildren()
                        @removeFromParent