angular.module 'Tienda'
.controller 'ComprasCreateController', (Compra, Producto, Organizacion, $scope, $location) ->
	$scope.compra = new Compra()
	$scope.compra.fecha = new Date()
	$scope.organizaciones = Organizacion.query()
	$scope.productos = Producto.query()
	$scope.no_hay_items = true
	$scope.compra.operacionitems = []
	$scope.focus_en_buscador = false
	$scope.compra.total = 0.00

	$scope.agregar_item = (producto) ->
		producto_en_lista = false
		angular.forEach $scope.compra.operacionitems, (v,i) ->
			importe = v["cantidad"] * v["precio"]
			$scope.compra.total += importe
			if v["producto"]["id"] == producto.id
				v["cantidad"] += 1
				producto.en_venta = v["cantidad"]
				producto_en_lista = true
		if producto_en_lista == false
			$scope.compra.operacionitems.push({"producto": {"id": producto.id, "nombre": producto.nombre}, "cantidad": 1, "precio": 10})
			producto.en_venta = 1
			$scope.compra.total += 10
		$scope.no_hay_items = false
		$scope.compra.organizacion_id = producto.organizacion_id if $scope.compra.operacionitems.length == 1

	$scope.restar_item = (producto) ->
		angular.forEach $scope.compra.operacionitems, (v,i) ->
			if v["producto"]["id"] == producto.id
				if v["cantidad"] != 1
					v["cantidad"] -= 1
					producto.en_venta = v["cantidad"]
					$scope.compra.total -= parseFloat(v["precio"])
				else
					$scope.compra.total -= parseFloat(v["precio"])
					$scope.compra.operacionitems.splice(i,1)
					producto.en_venta = 0
		$scope.no_hay_items = true if $scope.compra.operacionitems.length == 0

	$scope.$on '$locationChangeStart', (event) ->
		if !$scope.no_hay_items
			respuesta = confirm("Desea descartar la orden de compra?")
			event.preventDefault() if !respuesta

	$scope.editar_precio = ->
		$scope.compra.total = 0
		angular.forEach $scope.compra.operacionitems, (v,i) ->
			importe = v["cantidad"] * v["precio"]
			$scope.compra.total += importe

	$scope.confirmar_compra = () ->
		$scope.compra.$save()
		.then ->
			$scope.no_hay_items = true
			$location.path('/compras')
		.catch (err) ->
			console.log(err)
	
	$scope.elegir_otro = () ->
		$scope.search = ''
		$('#buscador').focus()


			
