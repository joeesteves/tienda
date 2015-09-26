angular.module 'Tienda'
.controller 'VentasCreateController', (Venta, Producto, $scope, $location) ->
	$scope.venta = new Venta()
	$scope.venta.fecha = new Date()	
	$scope.productos = Producto.query()
	$scope.no_hay_items = true
	$scope.venta.operacionitems = []
	$scope.focus_en_buscador = false
	$scope.venta.total = 0.00

	$scope.agregar_item = (producto) ->
		producto_en_lista = false
		angular.forEach $scope.venta.operacionitems, (v,i) ->
			if v["producto"]["id"] == producto.id
				v["cantidad"] += 1
				producto_en_lista = true
				$scope.venta.total += parseFloat(v["precio"])
		if producto_en_lista == false
			$scope.venta.operacionitems.push({"producto": {"id": producto.id, "nombre": producto.nombre}, "cantidad": 1, "precio": 10})
			$scope.venta.total += 10
		$scope.no_hay_items = false

	$scope.restar_item = (producto) ->
		angular.forEach $scope.venta.operacionitems, (v,i) ->
			if v["producto"]["id"] == producto.id
				if v["cantidad"] != 1
					v["cantidad"] -= 1
					$scope.venta.total -= parseFloat(v["precio"])
				else
					$scope.venta.total -= parseFloat(v["precio"])
					$scope.venta.operacionitems.splice(i,1)
		$scope.no_hay_items = true if $scope.venta.operacionitems.length == 0

	$scope.$on '$locationChangeStart', (event) ->
		if !$scope.no_hay_items
			respuesta = confirm("Desea descartar la orden de venta?")
			event.preventDefault() if !respuesta
	$scope.confirmar_venta = () ->
		$scope.venta.$save()
		.then ->
			$scope.no_hay_items = true
			$location.path('/ventas')
		.catch (err) ->
			console.log(err)
	$scope.elegir_otro = () ->
		$scope.search = ''
		$('#buscador').focus()


			
