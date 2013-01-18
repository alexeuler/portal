App.namespace 'Backbone', (ns)->
        class ns.CompositeView extends Backbone.View
                initialize:(options)->
                        @children=App.ExtractOptions(options, 'children') || []
                        @parent=App.ExtractOptions options, 'parent' 
                        super(options)

                remove:->
                        super
                        @unbind()
                        @deleteChildren()
                        @removeFromParent()