App.namespace 'App', (ns)->
        class ns.Iterator
                constructor:(options)->
                        @list=options['list']
                        @sort=options['sort']
                list:null
                sort:null        
                reset:null
                next:null
                hasNext:null
