angular.module 'Tienda' 
.controller 'VentasIndexController', (Venta, Producto, $scope) ->
	$scope.ventas = Venta.query()
	console.log($scope.ventas)
	$scope.pre_borrar = (objeto_a_borrar) ->
		$scope.objeto_a_borrar = objeto_a_borrar
	$scope.borrar = () ->
		$scope.objeto_a_borrar.$remove()
		.then ->
			$scope.ventas = Venta.query()