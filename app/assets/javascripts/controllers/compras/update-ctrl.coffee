angular.module 'Tienda'
.controller 'ComprasUpdateController', (Compra, Producto, Shared, $scope, $location, $routeParams) ->
	$scope.es_nuevo = false
	$scope.no_hay_items = false
	$scope.cant_prod = {}	
	Compra.get({id: $routeParams.id}).$promise
	.then (data) ->
		$scope.op = data
		$scope.op.fecha = new Date($scope.op.fecha + ' ')
		$scope.op.total = parseFloat($scope.op.total)
		$scope.organizaciones = data.organizacion
		Shared.actualizar_stock($scope)
	Producto.query().$promise.then (data) ->
		$scope.productos = data
	$scope.precios = Producto.precios()
	$scope.mostrar = Shared.mostrar()

	$scope.agregar_item = (producto) ->
		Shared.agregar_item($scope, producto)
	
	$scope.restar_item = (producto) ->
		Shared.restar_item($scope, producto)	

	$scope.editar_precio = ->
		Shared.editar_precio($scope)

	$scope.confirmar_operacion = ->
		Shared.confirmar_operacion($scope)

	$scope.$on '$locationChangeStart', (event) ->
		Shared.descartar_form($scope, event)