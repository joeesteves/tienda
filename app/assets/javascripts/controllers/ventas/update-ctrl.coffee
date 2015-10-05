angular.module 'Tienda'
.controller 'VentasUpdateController', (Venta, Producto, Shared, Pagotipo, $scope, $location, $routeParams) ->
	$scope.no_hay_items = false
	$scope.cant_prod = {} # {id_delproducto: cantidad}
	Venta.get({id: $routeParams.id}).$promise.then (data) ->
		$scope.op = data
		$scope.op.fecha = new Date($scope.op.fecha + ' ')
		$scope.op.reserva = ($scope.op.pago != $scope.op.total)
		$scope.op.total = parseFloat($scope.op.total)
		$scope.op.factor_original = $scope.op.pagotipo.factor
		Producto.query().$promise.then (data) ->
			$scope.productos = data
			$scope.precios = Producto.precios()
			Shared.actualizar_stock($scope)
		Pagotipo.query().$promise.then (data) ->
			$scope.pagotipos = data
	.catch (err) ->
		console.log(err)
	$scope.mostrar = Shared.mostrar()

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