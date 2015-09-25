angular.module 'Tienda' 
.controller 'ProductosIndexController', (Producto, $scope, $sanitize) ->
	$scope.productos = Producto.query()
	console.log($scope.productos)
	$scope.pre_borrar = (objeto_a_borrar) ->
		$scope.objeto_a_borrar = objeto_a_borrar
	$scope.borrar = () ->
		$scope.objeto_a_borrar.$remove()
		.then ->
			$scope.productos = Producto.query()