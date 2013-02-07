App.namespace 'App', (ns)->
        class ns.Iterator
                constructor:(options)->
                        @list=options['list']
                        @sort=App.CreateSort options['sort']
                        i=0
                        indexedArray=@list.map (element)->
                                [i++,element]
                        if options['sort'] then indexedArray=indexedArray.sort (a,b)=>
                                @sort a[1],b[1]
                        @index=indexedArray.map (element)->
                                element[0]
                        @reset()
                        
                reset: ->
                        @_current=0
                        
                next: ->
                        if @hasNext() 
                                @_current++
                                @current()
                        else
                                throw "Iterator out of bounds"

                current: ->
                        @list[@index[@_current]]
                        
                hasNext: ->
                        @_current+1<@index.length