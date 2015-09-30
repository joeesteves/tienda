angular.module 'Tienda' 
.controller 'ProductosIndexController', (Producto, $scope, $sanitize) ->
	Producto.query().$promise.then (data) ->
		$scope.productos = data
	Producto.precios().$promise.then (data) ->
		$scope.precios = data
	$scope.pre_borrar = (objeto_a_borrar) ->
		$scope.objeto_a_borrar = objeto_a_borrar
	$scope.borrar = () ->
		$scope.objeto_a_borrar.$remove()
		.then ->
			$scope.productos = Producto.query()