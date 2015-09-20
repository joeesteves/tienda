angular.module 'Tienda'
.factory 'Producto', ($resource) ->
	$resource("/productos/:id", {id: "@id"}, {update: {method: "PUT"}})