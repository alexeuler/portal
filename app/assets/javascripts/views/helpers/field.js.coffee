App.namespace 'App.Views.Helpers', (ns)->
        
        class ns.Field extends Backbone.View
                template:JST['templates/helpers/field']

                tagName:'tr'
                
                initialize:(options)->
                        
                        @render()
                render:->
                        @$el.html @template