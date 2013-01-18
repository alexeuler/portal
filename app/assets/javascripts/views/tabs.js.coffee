class App.Views.Tabs extends App.Classes.View
        
        template: JST['templates/tabs']

        el:'.tabs'

        tabs:
                buttons:
                        '/forum':'Форум'
                        '/home':'Главная'
                        '/map':'Карта'
                        '/sign_in': 'Войти'
                selected:'/forum'
                right:'/sign_in'
        

        initialize: (options) ->
                _.bindAll @
                @render()
                                        
        render: ->
                @$el.html @template({tabs:@tabs})

                                        
        