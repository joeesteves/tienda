angular.module 'Tienda'
.factory 'Compra', ($resource) ->
	$resource("/compras/:id", {id: "@id"}, {update: {method: "PUT"}})