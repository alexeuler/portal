window.App||={}

App.namespace = (target, name, block) ->
  [target, name, block] = [(if typeof exports isnt 'undefined' then exports else window), arguments...] if arguments.length < 3
  top    = target
  target = target[item] or= {} for item in name.split '.'
  block target, top

#Returns options specified by names and deletes them from options hash
# If only 1 name is passed, returns value of that option,
# o/w returns hash of extracted options
App.ExtractOptions = (options, names...) ->
        return unless options 
        result=_.pick(options, names...)
        for key in _(result).keys()
                delete options[key]
        if names.length is 1 then result[names[0]] else result


# Returns a function that extracts fields
# E.g. a={name:{nested:1}}
# extractor=App.FieldExtractor('name.nested')
# Then extractor(a)=1
# If name='', null, or undefined returns (x)->x
App.FieldExtractor = (name)->
        if name is ''
                fields=null
        else
                try
                        fields=name?.split '.'
                catch error
                        throw "String expected"
        (x)->
                if fields? then x=x[item] for item in fields
                x

# Returns sort function
# Options:
#    -field: the field by which sort is performed, e.g. name.nested. If undefined sorts by object itself
#    -order: if 'desc' then sorts descending o/w ascending
App.CreateSort=(options={})->
        fields=options['field']?.split(' ') || [null]
        extractors=fields.map (field)->App.FieldExtractor field
        if options['order'] is 'desc' then order=-1 else order=1
        result=(a,b)->
                for extractor in extractors
                        switch true
                                when extractor(a)<extractor(b) then return -order
                                when extractor(a)>extractor(b) then return order
                0