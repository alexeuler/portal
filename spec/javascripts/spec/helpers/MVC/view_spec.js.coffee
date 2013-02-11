describe "App.MVC.View", ->
        it 'intializes parameters in constructor or uses default values', ->
                view=new App.MVC.View
                        children:[1,2,3]
                        model:'model'
                expect(view.children).toEqual [1,2,3]
                expect(view.model).toEqual 'model'
                expect(view.sort).toEqual App.MVC.View.prototype.sort

        describe 'addChildren', ->
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

        it 'uses getElement helper which defaults to parent of none children are found and returns one if many are found', ->
                container=$('<div>')
                child1=$('<li>')
                child1.addClass 'one'
                container.append child1
                child2=$('<li>')
                child2.addClass 'many'
                container.append child2
                child3=$('<li>')
                child3.addClass 'many'
                container.append child3
                expect(App.MVC.View.prototype.getElement(container,'whatever')).toBe container
                expect(App.MVC.View.prototype.getElement(container,'.one')).toBe child1
                expect(App.MVC.View.prototype.getElement(container,'.many')).toBe child2                