App.namespace 'App', (ns)->
        class ns.Iterator
                constructor:(options)->
                        @list=options['list']
                        @sort=options['sort']
                        i=0
                        indexed_array=@list.map (element)->
                                [i++,element]
                        if @sort then indexed_array=indexed_array.sort (a,b)=>
                                @sort a[1],b[1]
                        @index=indexed_array.map (element)->
                                element[0]
                        @reset()
                        
                reset: ->
                        @_current=0
                        
                next: ->
                        @_current++
                        @current()

                current: ->
                        @list[@index[@_current]]
                        
                hasNext: ->
                        @_current+1<@index.length