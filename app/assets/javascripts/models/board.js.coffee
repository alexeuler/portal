class App.Models.Board extends Backbone.Model
        urlRoot : '/forum/boards'

        initialize:->
                @on 'change:board_group', @updateGroup
                @updateGroup()
        
        updateGroup:->
                @group=new App.Models.BoardGroup @get('board_group')
