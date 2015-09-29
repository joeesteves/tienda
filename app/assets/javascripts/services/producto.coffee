angular.module 'Tienda'
.factory 'Producto', ($resource) ->
	$resource("/productos/:id", {id: "@id"}, {update: {method: "PUT"}, precios: {method: "GET", url: '/productos/precios' }})
	# precios: ->
	# 	$http({method: 'GET', url: 'productos/precios'})