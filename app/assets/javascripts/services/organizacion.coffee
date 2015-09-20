angular.module 'Tienda'
.factory 'Organizacion', ($resource) ->
	$resource("/organizaciones/:id", {id: "@id"}, {update: {method: "PUT"}})