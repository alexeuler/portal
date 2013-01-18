class App.Models.Board extends App.Classes.Model
        urlRoot : '/forum/boards'

        initialize:->
                @on 'change:board_group', @updateGroup
                @updateGroup()
        
        updateGroup:->
                @group=new App.Models.BoardGroup @get('board_group')
