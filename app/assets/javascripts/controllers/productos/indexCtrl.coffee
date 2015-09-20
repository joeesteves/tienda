angular.module 'Tienda' 
.controller 'ProductosIndexController', (Producto, Organizacion, $scope, $sanitize) ->
	$scope.productos = Producto.query()
	$scope.pre_borrar = (objeto_a_borrar) ->
		$scope.objeto_a_borrar = objeto_a_borrar
	$scope.borrar = () ->
		$scope.objeto_a_borrar.$remove()
		.then ->
			$scope.productos = Producto.query()