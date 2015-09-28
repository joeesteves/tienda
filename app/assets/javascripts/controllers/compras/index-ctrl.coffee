angular.module 'Tienda' 
.controller 'ComprasIndexController', (Compra, Producto, $scope) ->
	$scope.compras = Compra.query()
	console.log($scope.compras)
	$scope.pre_borrar = (objeto_a_borrar) ->
		$scope.objeto_a_borrar = objeto_a_borrar
	$scope.borrar = () ->
		$scope.objeto_a_borrar.$remove()
		.then ->
			$scope.compras = Compra.query()