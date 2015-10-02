angular.module 'Tienda'
.controller 'VentasCreateController', (Venta, Producto, Pagotipo, Shared, $scope, $location) ->
	$scope.no_hay_items = true
	$scope.op = new Venta()
	$scope.op.fecha = new Date()
	$scope.op.total = 0.00
	Producto.query().$promise.then (data) ->
		$scope.productos = data
	$scope.op.operacionitems = []
	$scope.cant_prod = {} # {id_delproducto: cantidad}
	$scope.precios = Producto.precios()
	Pagotipo.query().$promise
	.then (data) ->
		$scope.pagotipos = data
		$scope.op.pagotipo_id = $scope.pagotipos[0].id
		$scope.op.factor_original = $scope.pagotipos[0].factor

	$scope.agregar_item = (producto) ->
		if $scope.precios[producto.id] == undefined
			precio = 0 
		else
			precio = parseFloat(($scope.precios[producto.id].precio * $scope.op.factor_original).toFixed(2))
		producto_en_lista = false
		angular.forEach $scope.op.operacionitems, (v,i) ->
			if v.producto.id == producto.id
				v.cantidad += 1
				$scope.cant_prod[producto.id] = v.cantidad
				producto_en_lista = true
				$scope.op.total += parseFloat(v.precio)
		if producto_en_lista == false
			nuevo_item = {"producto": {"id": producto.id, "nombre": producto.nombre}, "cantidad": 1, "precio": precio}
			$scope.op.operacionitems.push(nuevo_item)
			$scope.cant_prod[producto.id] = 1
			$scope.op.total +=  parseFloat(nuevo_item.precio)
		$scope.no_hay_items = false

	$scope.restar_item = (producto) ->
		angular.forEach $scope.op.operacionitems, (v,i) ->
			if v.producto.id == producto.id
				if v.cantidad != 1
					v.cantidad -= 1
					$scope.cant_prod[producto.id] = v.cantidad
					$scope.op.total -= parseFloat(v.precio)
				else
					$scope.op.total -= parseFloat(v.precio)
					$scope.op.operacionitems.splice(i,1)
					$scope.cant_prod[producto.id] = 0
		$scope.no_hay_items = true if $scope.op.operacionitems.length == 0

	$scope.$on '$locationChangeStart', (event) ->
		if !$scope.no_hay_items
			respuesta = confirm("Desea descartar la orden de venta?")
			event.preventDefault() if !respuesta
	
	$scope.confirmar_operacion = () ->
		$scope.op.pago = $scope.op.total if $scope.op.reserva != true
		$scope.op.$save()
		.then ->
			$scope.no_hay_items = true
			$location.path('/ventas')
		.catch (err) ->
			console.log(err)

	$scope.editar_precio = () ->
		Shared.editar_precio($scope)

	$scope.actualizar_precio_pagotipo = (pagotipo) ->
		angular.forEach $scope.op.operacionitems, (item,i) ->
			item.precio = parseFloat((item.precio * pagotipo.factor / $scope.op.factor_original).toFixed(2))
		$scope.op.factor_original =  pagotipo.factor
		$scope.editar_precio()
			
