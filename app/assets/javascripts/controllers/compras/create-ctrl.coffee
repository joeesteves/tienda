angular.module 'Tienda'
.controller 'ComprasCreateController', (Compra, Producto, Organizacion, Shared, $scope, $location) ->
	$scope.es_nuevo = true
	$scope.no_hay_items = true
	$scope.op = new Compra()
	$scope.op.fecha = new Date()
	$scope.op.operacionitems = []
	$scope.op.total = 0.00
	$scope.cant_prod = {}
	Organizacion.query().$promise.then (data) ->
		$scope.organizaciones = data 
	Producto.query().$promise.then (data) ->
		$scope.productos = data
	$scope.precios = Producto.precios()
	
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