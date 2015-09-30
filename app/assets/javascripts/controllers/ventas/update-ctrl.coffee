angular.module 'Tienda'
.controller 'VentasUpdateController', (Venta, Producto, Pagotipo, $scope, $location, $routeParams) ->
	Venta.get({id: $routeParams.id}).$promise
	.then (data) ->
		$scope.venta = data
		$scope.venta.fecha = new Date($scope.venta.fecha)
		$scope.venta.reserva = ($scope.venta.pago != $scope.venta.total)
		$scope.venta.total = parseFloat($scope.venta.total)
		$scope.cant_prod_en_venta = {} # {id_delproducto: cantidad}
		actualizar_stocks()
		$scope.productos = Producto.query()
		$scope.no_hay_items = false
		$scope.pagotipos = Pagotipo.query()
		$scope.venta.factor_original = $scope.venta.pagotipo.factor
		$scope.precios = Producto.precios()
	.catch (err) ->
		alert(err)

	actualizar_stocks = ->
		angular.forEach $scope.venta.operacionitems, (v,i) ->
			$scope.cant_prod_en_venta[v.producto_id] = v.cantidad

	$scope.agregar_item = (producto) ->
		producto_en_lista = false
		if $scope.precios[producto.id] == undefined
			precio = 0 
		else
			precio = parseFloat(($scope.precios[producto.id].precio * $scope.venta.factor_original).toFixed(2))
		producto_en_lista = false
		angular.forEach $scope.venta.operacionitems, (v,i) ->
			if v.producto.id == producto.id
				v.cantidad += 1
				$scope.cant_prod_en_venta[v.producto.id] = v.cantidad
				producto_en_lista = true
				$scope.venta.total += parseFloat(v.precio)
				v["_destroy"] = false
		if producto_en_lista == false
			nuevo_item = {"producto": {"id": producto.id, "nombre": producto.nombre}, "cantidad": 1, "precio": precio}
			$scope.venta.operacionitems.push(nuevo_item)
			$scope.venta.total += nuevo_item.precio
			$scope.cant_prod_en_venta[producto.id] = 1
		$scope.no_hay_items = false

	$scope.restar_item = (producto) ->
		cantidad_items = 0
		angular.forEach $scope.venta.operacionitems, (v,i) ->
			if v["_destroy"] != true
				cantidad_items += 1	
				if v["producto"]["id"] == producto.id
					if v["cantidad"] != 1
						$scope.venta.total -= parseFloat(v["precio"])
					else
						cantidad_items -= 1
						$scope.venta.total -= parseFloat(v["precio"])
						v["_destroy"] = true
					v["cantidad"] -= 1
					$scope.cant_prod_en_venta[v.producto_id] = v.cantidad
		$scope.no_hay_items = true if cantidad_items == 0

	$scope.$on '$locationChangeStart', (event) ->
		if !$scope.no_hay_items
			respuesta = confirm("Desea descartar la orden de venta?")
			event.preventDefault() if !respuesta

	$scope.confirmar_venta = () ->
		$scope.venta.pago = $scope.venta.total if $scope.venta.reserva != true
		$scope.venta.$update()
		.then ->
			$scope.no_hay_items = true
			$location.path('/ventas')
		.catch (err) ->
			alert(err)
		console.log($scope.venta)
	
	$scope.editar_precio = ->
		$scope.venta.total = 0
		angular.forEach $scope.venta.operacionitems, (item,i) ->
			importe = parseFloat((item.cantidad * item.precio).toFixed(2))
			$scope.venta.total += parseFloat(importe.toFixed(2))
	$scope.actualizar_precio_pagotipo = (pagotipo) ->
		angular.forEach $scope.venta.operacionitems, (item,i) ->
			item.precio = parseFloat((item.precio * pagotipo.factor / $scope.venta.factor_original).toFixed(2))
		$scope.venta.factor_original =  pagotipo.factor
		$scope.editar_precio()
			