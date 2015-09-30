angular.module 'Tienda' 
.controller 'VentasIndexController', (Venta, Producto, $scope) ->
	Venta.query().$promise
	.then (data) ->
		angular.forEach data, (venta) ->
			venta.idsearch = '.' + venta.id
		$scope.ventas = data

	$scope.pre_borrar = (objeto_a_borrar) ->
		$scope.objeto_a_borrar = objeto_a_borrar
	$scope.borrar = () ->
		$scope.objeto_a_borrar.$remove()
		.then ->
			$scope.ventas = Venta.query()