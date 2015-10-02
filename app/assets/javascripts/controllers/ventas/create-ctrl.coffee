angular.module 'Tienda'
.controller 'VentasCreateController', (Venta, Producto, Pagotipo, Shared, $scope, $location) ->
	$scope.no_hay_items = true
	$scope.cant_prod = {} # {id_delproducto: cantidad}
	$scope.op = new Venta()
	$scope.op.fecha = new Date()
	$scope.op.total = 0.00
	$scope.op.operacionitems = []
	Producto.query().$promise.then (data) ->
		$scope.productos = data
	Pagotipo.query().$promise.then (data) ->
		$scope.pagotipos = data
		$scope.op.pagotipo_id = $scope.pagotipos[0].id
		$scope.op.factor_original = $scope.pagotipos[0].factor
	$scope.precios = Producto.precios()

	$scope.agregar_item = (producto) ->
		Shared.agregar_item($scope, producto)

	$scope.restar_item = (producto) ->
		Shared.restar_item($scope, producto)

	$scope.confirmar_operacion = () ->
		Shared.confirmar_operacion($scope)

	$scope.editar_precio = () ->
		Shared.editar_precio($scope)

	$scope.actualizar_precio_pagotipo = (pagotipo) ->
		Shared.actualizar_precio_pagotipo($scope, pagotipo)
		
	$scope.$on '$locationChangeStart', (event) ->
		Shared.descartar_form($scope, event)