describe 'Iterator', ->
        it 'creates new iterator', ->
                iterator=new App.Iterator list:[1,2,3]
                expect(iterator).toBeDefined()
                expect(iterator.list).toEqual([1,2,3])                