describe "App.MVC.View", ->
        it 'intializes in constructor or uses default values', ->
                view=new App.MVC.View
                        children:[1,2,3]
                        model:'model'
                expect(view.children).toEqual [1,2,3]
                expect(view.model).toEqual 'model'
                expect(view.sort).toEqual App.MVC.View.prototype.sort

        it 'adds children with options', ->
                view=new App.MVC.View
                view.addChild children:[1,2,3], container:'.list'
                view.addChild parent:'parent'
                expect(view.children.length).toEqual 2
                expect(view.children[0].children).toEqual [1,2,3]
                expect(view.children[0].container).toEqual '.list'
                expect(view.children[0].parent).toBe view
                expect(view.children[1].parent).toEqual 'parent'

        it 'filters children by field and value', ->
                view=new App.MVC.View
                view.children.push(new App.MVC.View container:'.global')
                view.children.push(new App.MVC.View container:'.global')
                view.children.push(new App.MVC.View container:'.local')
                expect(-> view.filterChildren('container')).toThrow "Value must be specified"
                expect(view.filterChildren('container','.global').length).toEqual 2
                expect(view.filterChildren('container','.local').length).toEqual 1
                expect(view.filterChildren('container','.')).toEqual []
                expect(view.filterChildren('container.whatever','.')).toEqual []
                expect(view.filterChildren('container.whatever.c',',')).toEqual []