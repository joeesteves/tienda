angular.module 'Tienda'
.controller 'ProductosCreateController', (Producto, Organizacion, $scope, $location) ->
	$scope.organizaciones = Organizacion.query()
	$scope.producto = new Producto()
	$scope.guardar = () ->
		$scope.producto.$save()
		.then ->
			$location.path('/productos')
		.catch (error) ->
			alert(error['statusText'])

