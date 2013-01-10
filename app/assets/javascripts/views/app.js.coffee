class App.Views.App extends Backbone.View
        template:JST['templates/app']
        
        el:'body'
        
        initialize:->
                @render()
        render:->
                @tabs=
                        buttons:
                                '/forum':'Форум'
                                '/home':'Главная'
                                '/map':'Карта'
                                '/sign_in': 'Войти'
                        selected:'/forum'
                        right:'/sign_in'
                @$el.html @template tabs:@tabs
        