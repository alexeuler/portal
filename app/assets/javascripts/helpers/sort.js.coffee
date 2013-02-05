App.namespace 'App', (ns)->
        ns.CreateSort=(options={})->
                field=options['field']||(x)->x
                if options['order'] is 'desc' then order=-1 else order=1
                result=(a,b)->
                        switch true
                                when field(a)<field(b) then -order
                                when field(a) is field(b) then 0
                                else order                                