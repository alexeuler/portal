describe 'App.Iterator', ->
        
        it 'iterates as is if sort is null', ->
                list=[1,2,3,4,3]
                iterator=new App.Iterator list:list
                result=[iterator.current()]
                while iterator.hasNext()
                        result.push(iterator.next())
                expect(result).toEqual(list)

        it 'iterates backwards with reverse sort', ->
                list=[1,2,3,4,3]                
                iterator=new App.Iterator
                        list:list
                        sort:
                                order:'desc'
                result=[iterator.current()]
                while iterator.hasNext()
                        result.push(iterator.next())
                expect(result).toEqual([4,3,3,2,1])

        it 'iterates with sort by field', ->
                list=[{a:1},{a:2},{a:3},{a:4},{a:3}]                
                iterator=new App.Iterator
                        list:list
                        sort:
                                field:'a'
                                order:'desc'
                result=[iterator.current()]
                while iterator.hasNext()
                        result.push(iterator.next())
                expect(result.map (x)->x.a).toEqual [4,3,3,2,1]


        it 'throws an exception when out of bounds', ->
                list=[1,2,3]
                iterator=new App.Iterator list:list
                iterator.next()
                iterator.next()
                expect(-> iterator.next()).toThrow("Iterator out of bounds")

        it 'executes functions in forEach cycle', ->
                list=[1,2,3]
                iterator=new App.Iterator list:list
                result=[]
                iterator.forEach (x)->result.push x
                expect(result).toEqual list

        it 'has current - undefined, hasNext - false, forEach does nothing when array is empty', ->
                iterator=new App.Iterator list:[]
                expect(iterator.current()).toBeUndefined()
                expect(iterator.hasNext()).toBeFalsy()
                i=0
                iterator.forEach ->i++
                expect(i).toEqual 0