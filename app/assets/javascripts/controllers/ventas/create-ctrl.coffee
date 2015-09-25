angular.module 'Tienda'
.controller 'VentasCreateController', (Producto, Organizacion, $scope) ->
	$scope.productos = Producto.query()
	$scope.no_hay_items = true
	$scope.ventas = []
	$scope.total = 0
	console.log($scope.ventas)
	$scope.agregar_item = (producto) ->
		producto_en_lista = false
		angular.forEach $scope.ventas, (v,i) ->
			if v["producto_id"] == producto.id
				v["cantidad"] += 1
				producto_en_lista = true
				$scope.total += v["precio"]
		if producto_en_lista == false
			$scope.ventas.push({"producto_id": producto.id, "producto_nombre": producto.nombre, "cantidad": 1, "precio": 10})
			$scope.total += 10
		$scope.no_hay_items = false

	$scope.restar_item = (producto) ->
		angular.forEach $scope.ventas, (v,i) ->
			if v["producto_id"] == producto.id
				if v["cantidad"] != 1
					v["cantidad"] -= 1
					$scope.total -= v["precio"]
				else
					$scope.total -= v["precio"]
					$scope.ventas.splice(i,1)
		$scope.no_hay_items = true if $scope.ventas.length == 0
		console.log($scope.ventas)

	$scope.$on '$locationChangeStart', (event) ->
		if !$scope.no_hay_items
			respuesta = confirm("Desea descartar la orden de venta?")
			event.preventDefault() if !respuesta
			
