angular.module 'Tienda' 
.controller 'ComprasIndexController', (Compra, Producto, $scope) ->
	Compra.query().$promise
	.then (data) ->
		angular.forEach data, (compra) ->
			compra.idsearch = '..' + compra.id
		$scope.compras = data

	$scope.pre_borrar = (objeto_a_borrar) ->
		$scope.objeto_a_borrar = objeto_a_borrar
	$scope.borrar = () ->
		$scope.objeto_a_borrar.$remove()
		.then ->
			$scope.compras = Compra.query()