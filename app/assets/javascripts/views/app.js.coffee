class App.Views.App extends Backbone.View
        template:JST['templates/app']
        
        el:'body'
        
        initialize:->
                @render()
        render:->
                @$el.html @template
                @tabs=new window.App.Views.Tabs()
        remove:->
                @tabs.remove()
        