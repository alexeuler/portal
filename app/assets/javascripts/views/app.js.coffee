class App.Views.App extends Backbone.View
        template:JST['templates/app']
        
        el:'body'
        
        initialize:->
                @render()
        render:->
                tabs=
                        '/forum':'Форум'
                        '/home':'Главная'        
                @$el.html @template tabs:tabs
        