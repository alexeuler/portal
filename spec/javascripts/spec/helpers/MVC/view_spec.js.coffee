describe "App.MVC.View", ->
        it 'intializes in constructor or uses default values', ->
                view=new App.MVC.View
                        children:[1,2,3]
                        model:'model'
                expect(view.children).toEqual [1,2,3]
                expect(view.model).toEqual 'model'
                expect(view.sort).toEqual App.MVC.View.prototype.sort