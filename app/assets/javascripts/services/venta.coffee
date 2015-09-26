angular.module 'Tienda'
.factory 'Venta', ($resource) ->
	$resource("/ventas/:id", {id: "@id"}, {update: {method: "PUT"}})