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
        result=_.pick(options, names...)
        for key in _(result).keys()
                delete options[key]
        if names.length is 1 then result[names[0]] else result

