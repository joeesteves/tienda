angular.module 'Tienda'
.filter 'objeto', ->
  (input, search) ->
    return input if (!input) 
    return input if (!search)
    result = {}
    angular.forEach input, (value, key) ->
      if (new RegExp(search, "i").test(value.nombre))
        result[key] = value
    return result