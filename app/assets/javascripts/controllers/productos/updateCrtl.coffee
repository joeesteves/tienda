angular.module 'Tienda'
.controller 'ProductosUpdateController', (Producto, Organizacion, $scope, $location, $routeParams) ->
	$scope.organizaciones = Organizacion.query()
	Producto.get {id: $routeParams.id}, (data) ->
		$scope.producto = data
	$scope.guardar = () ->
		$scope.producto.$update()
		.then ->
			$location.path('/productos')
		.catch (error) ->
			alert(error['statusText'])

