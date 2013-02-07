# Iterator class
# Iterates through a COPY of array, specified by list parameter
# Options:
#   -list: list to iterate through
#   -sort: parameters to iterate in particular order (see sort)

App.namespace 'App', (ns)->
        class ns.Iterator
                constructor:(options)->
                        @list=options['list']
                        @sort=options['sort']
                        @reset()
                        
                reset: ->
                        i=0
                        indexedArray=@list.map (element)->
                                [i++,element]
                        if @sort 
                                sortFunction=App.CreateSort @sort
                                indexedArray=indexedArray.sort (a,b)=>
                                        sortFunction a[1],b[1]
                        @index=indexedArray.map (element)->
                                element[0]                        
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