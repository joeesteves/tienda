angular.module 'Tienda'
.factory 'Pagotipo', ($resource) ->
	$resource("/pagotipos/:id", {id: "@id"}, {update: {method: "PUT"}})