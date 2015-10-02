angular.module 'Tienda'
.controller 'VentasUpdateController', (Venta, Producto, Shared, Pagotipo, $scope, $location, $routeParams) ->
	Venta.get({id: $routeParams.id}).$promise
	.then (data) ->
		$scope.op = data
		$scope.op.fecha = new Date($scope.op.fecha)
		$scope.op.reserva = ($scope.op.pago != $scope.op.total)
		$scope.op.total = parseFloat($scope.op.total)
		$scope.cant_prod_en_venta = {} # {id_delproducto: cantidad}
		actualizar_stocks()
		$scope.productos = Producto.query()
		$scope.no_hay_items = false
		$scope.pagotipos = Pagotipo.query()
		$scope.op.factor_original = $scope.op.pagotipo.factor
		$scope.precios = Producto.precios()
	.catch (err) ->
		alert(err)

	actualizar_stocks = ->
		angular.forEach $scope.op.operacionitems, (v,i) ->
			$scope.cant_prod_en_venta[v.producto_id] = v.cantidad

	$scope.agregar_item = (producto) ->
		producto_en_lista = false
		if $scope.precios[producto.id] == undefined
			precio = 0 
		else
			precio = parseFloat(($scope.precios[producto.id].precio * $scope.op.factor_original).toFixed(2))
		producto_en_lista = false
		angular.forEach $scope.op.operacionitems, (v,i) ->
			if v.producto.id == producto.id
				v.cantidad += 1
				$scope.cant_prod_en_venta[v.producto.id] = v.cantidad
				producto_en_lista = true
				$scope.op.total += parseFloat(v.precio)
				v["_destroy"] = false
		if producto_en_lista == false
			nuevo_item = {"producto": {"id": producto.id, "nombre": producto.nombre}, "cantidad": 1, "precio": precio}
			$scope.op.operacionitems.push(nuevo_item)
			$scope.op.total += nuevo_item.precio
			$scope.cant_prod_en_venta[producto.id] = 1
		$scope.no_hay_items = false

	$scope.restar_item = (producto) ->
		cantidad_items = 0
		angular.forEach $scope.op.operacionitems, (v,i) ->
			if v["_destroy"] != true
				cantidad_items += 1	
				if v["producto"]["id"] == producto.id
					if v["cantidad"] != 1
						$scope.op.total -= parseFloat(v["precio"])
					else
						cantidad_items -= 1
						$scope.op.total -= parseFloat(v["precio"])
						v["_destroy"] = true
					v["cantidad"] -= 1
					$scope.cant_prod_en_venta[v.producto_id] = v.cantidad
		$scope.no_hay_items = true if cantidad_items == 0

	$scope.$on '$locationChangeStart', (event) ->
		if !$scope.no_hay_items
			respuesta = confirm("Desea descartar la orden de venta?")
			event.preventDefault() if !respuesta

	$scope.confirmar_operacion = () ->
		$scope.op.pago = $scope.op.total if $scope.op.reserva != true
		$scope.op.$update()
		.then ->
			$scope.no_hay_items = true
			$location.path('/ventas')
		.catch (err) ->
			alert(err)
		console.log($scope.op)
	
	$scope.editar_precio = () ->
		$scope.op.total = Shared.editar_precio($scope.op)

	$scope.actualizar_precio_pagotipo = (pagotipo) ->
		angular.forEach $scope.op.operacionitems, (item,i) ->
			item.precio = parseFloat((item.precio * pagotipo.factor / $scope.op.factor_original).toFixed(2))
		$scope.op.factor_original =  pagotipo.factor
		$scope.editar_precio()
			