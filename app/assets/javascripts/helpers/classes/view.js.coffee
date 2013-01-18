App.namespace 'App.Classes', (ns)->
        class ns.View extends Backbone.View
                parent: null
                container: ''
                children: []
                order:0
                
                initialize: (options)->
                        @parent&&=App.ExtractOptions options, 'parent'
                        @container&&=App.ExtractOptions options, 'container'
                        @order&&=App.ExtractOptions options, 'order'
                        @children&&=App.ExtractOptions options, 'children'
                        @sortChildren()
                        super(options)

                sortChildren: ->
                        @children.sort (a,b)->
                                switch true
                                        when a.container>b.container then 1
                                        when a.container<b.container then -1
                                        else switch true
                                                when _.result(a.order)>_.result(b.order) then 1
                                                when _.result(a.order)<_.result(b.order) then -1
                                                else 0
                        

                render: ->
                        if @template
                                @$el.html(@template model:@model.toJSON())
                        else
                                @$el.empty()
                        for child in @children
                                child.render()
                                container=@$el.find("#{child.container}")
                                switch container.length
                                        when 0 then @$el.append child.$el
                                        when 1 then container.append child.$el
                                        else throw exception:
                                                message:"Not unique container"
                                                containers:container
                                                
                addChild: (options)->
                        
                remove: ->
                        super
                        @unbind()
                        @deleteChildren()
                        @removeFromParent()