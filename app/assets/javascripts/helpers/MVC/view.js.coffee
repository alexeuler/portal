App.namespace 'App.MVC', (ns)->
        class ns.View extends Backbone.View
                
                constructor: (options)->
                        for name in ['parent', 'sort', 'children', 'container','iterator']
                                @[name]=App.ExtractOptions(options, name)||@[name]
                        @children||=[]
                        super(options)

                forEach:  (func, order)->
                        _iterator=iterator||new App.Iterator list:@children, sort:@sort
                        _iterator.forEach (child)->
                                func(child) unless order is 'post' 
                                child.forEach(func)
                                func(child) if order is 'post' 

                forEachChild: (func)->
                        _iterator=@iterator||new App.Iterator list:@children, sort:@sort
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
                                                
                addChild: (child, options)->
                        renderOnAdd=App.ExtractOptions options, 'render'
                        options=_.defaults options || {}, parent:@
                        child[key]=value for key, value of options
                        child.render() if renderOnAdd
                        if @sort
                                sortFunction=App.CreateSort field:@sort
                                insertBefore=null
                                try
                                        _iterator=new App.Iterator list:@filterChildren('container',child.container), sort:@sort
                                        _iterator.forEach (_child)->
                                                throw _child unless sortFunction(child, _child) is 1
                                catch _child
                                        insertBefore=_child
                                if insertBefore
                                        child.$el.insertBefore insertBefore.$el
                                else
                                        @getElement(@$el,child.container).append child.$el
                        else
                                @getElement(@$el,child.container).append child.$el
                        @children.push child
                                

                find: (field, value)->
                        result
                        extractor=new App.FieldExtractor field
                        @forEach (child)->
                                if extractor child is value then result=child
                        
                findChild: (field, value)->

                filterChildren: (field, value)->
                        result=[]
                        extractor=new App.FieldExtractor field
                        @forEachChild (child)->
                                try
                                        extracted=extractor(child)
                                catch e
                                        extracted=null
                                result.push child if extracted is value
                        result

                getElement: (el, selector)->
                        result=el.find(selector)
                        if result.length is 0 then return el
                        $(result[0])
                

                remove: ->
                        super
                        @unbind()
                        @deleteChildren()
                        @removeFromParent