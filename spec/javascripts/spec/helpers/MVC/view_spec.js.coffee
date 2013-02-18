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
                        #view.addChild(new App.MVC.View(children:[1,2,3], container:'.list'))
                        #view.addChild(new App.MVC.View, parent:'parent')
                        #expect(view.children.length).toEqual 2
                        #expect(view.children[0].children).toEqual [1,2,3]
                        #expect(view.children[0].container).toEqual '.list'
                        #expect(view.children[0].parent).toBe view
                        #expect(view.children[1].parent).toEqual 'parent'

                it 'automatically sorts inserted child if sort is specified', ->
                        el=$('<div>')
                        containers=[1..2].map (x)->$("<div id='container#{x}'></div>")
                        el.append containers[i] for i in [0..1]
                        view=new App.MVC.View sort: 'container model.num', el:el
                        view.addChild(new App.MVC.View(model:{num:7}, id:1))
                        view.addChild(new App.MVC.View(model:{num:2},container:'#container2', id:2))
                        view.addChild(new App.MVC.View(model:{num:1},container:'#container1', id:3))
                        view.addChild(new App.MVC.View(model:{num:1},container:'#container2', id:4))
                        view.addChild(new App.MVC.View(model:{num:3},container:'#container1', id:5))
                        view.addChild(new App.MVC.View(model:{num:2},container:'#container1', id:6))
                        view.addChild(new App.MVC.View(model:{num:5}, id:7))
                        expect(view.$el.find('#container1').children().map(->parseInt(@id)).get()).toEqual([3,6,5])
                        expect(view.$el.find('#container2').children().map(->parseInt(@id)).get()).toEqual([4,2])
                        expect(view.$el.children().not('#container1').not('#container2').map(->parseInt(@id)).get()).toEqual([7,1])
                        


        it 'filters children by field and value', ->
                view=new App.MVC.View
                view.children.push(new App.MVC.View container:'.global')
                view.children.push(new App.MVC.View container:'.global')
                view.children.push(new App.MVC.View container:'.local')
                view.children.push(new App.MVC.View)
                expect(view.filterChildren('container').length).toEqual 1
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