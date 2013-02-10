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