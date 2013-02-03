describe 'Iterator', ->
        
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
                        sort:(a,b)->
                                switch true
                                        when a>b then -1
                                        when a is b then 0
                                        else 1
                result=[iterator.current()]
                while iterator.hasNext()
                        result.push(iterator.next())
                expect(result).toEqual([4,3,3,2,1])                                