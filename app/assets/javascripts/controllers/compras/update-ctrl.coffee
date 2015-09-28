angular.module 'Tienda'
.controller 'CompraUpdateController', (Compra, Producto, $scope, $location, $routeParams) ->
	Compra.get({id: $routeParams.id}).$promise
	.then (data) ->
		$scope.compra = data
		$scope.compra.fecha = new Date()	
		$scope.productos = Producto.query()
		$scope.no_hay_items = false
		$scope.compra.total = parseFloat($scope.compra.total)
	.catch (err) ->
		alert(err)
	
	$scope.agregar_item = (producto) ->
		producto_en_lista = false
		angular.forEach $scope.compra.operacionitems, (v,i) ->
			if v["producto"]["id"] == producto.id
				v["cantidad"] += 1
				producto_en_lista = true
				$scope.compra.total += parseFloat(v["precio"])
				v["_destroy"] = false
		if producto_en_lista == false
			$scope.compra.operacionitems.push({"producto": {"id": producto.id, "nombre": producto.nombre}, "cantidad": 1, "precio": 10})
			$scope.compra.total += 10
		$scope.no_hay_items = false

	$scope.restar_item = (producto) ->
		cantidad_items = 0
		angular.forEach $scope.compra.operacionitems, (v,i) ->
			if v["_destroy"] != true
				cantidad_items += 1	
				if v["producto"]["id"] == producto.id
					if v["cantidad"] != 1
						$scope.compra.total -= parseFloat(v["precio"])
					else
						cantidad_items -= 1
						$scope.compra.total -= parseFloat(v["precio"])
						v["_destroy"] = true
					v["cantidad"] -= 1
		$scope.no_hay_items = true if cantidad_items == 0

	$scope.$on '$locationChangeStart', (event) ->
		if !$scope.no_hay_items
			respuesta = confirm("Desea descartar la orden de compra?")
			event.preventDefault() if !respuesta
	$scope.editar_precio = ->
		$scope.compra.total = 0
		angular.forEach $scope.compra.operacionitems, (v,i) ->
			importe = v["cantidad"] * v["precio"]
			$scope.compra.total += importe


	$scope.confirmar_venta = () ->
		$scope.compra.$update()
		.then ->
			$scope.no_hay_items = true
			$location.path('/compras')
		.catch (err) ->
			alert(err)
		console.log($scope.compra)