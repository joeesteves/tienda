angular.module 'Tienda'
.controller 'VentasUpdateController', (Venta, Producto, $scope, $location, $routeParams) ->
	Venta.get({id: $routeParams.id}).$promise
	.then (data) ->
		$scope.venta = data
		$scope.venta.fecha = new Date()	
		$scope.venta.operacionitems_attributes = $scope.venta.operacionitems
		$scope.productos = Producto.query()
		$scope.no_hay_items = false
		$scope.total = 100
	.catch (err) ->
		alert(err)
	
	$scope.agregar_item = (producto) ->
		producto_en_lista = false
		angular.forEach $scope.venta.operacionitems_attributes, (v,i) ->
			if v["producto_id"] == producto.id
				v["cantidad"] += 1
				producto_en_lista = true
				$scope.total += v["precio"]
		if producto_en_lista == false
			$scope.venta.operacionitems_attributes.push({"producto_id": producto.id, "producto": {"nombre": producto.nombre}, "cantidad": 1, "precio": 10})
			$scope.total += 10
		$scope.no_hay_items = false

	$scope.restar_item = (producto) ->
		angular.forEach $scope.venta.operacionitems_attributes, (v,i) ->
			if v["producto_id"] == producto.id
				if v["cantidad"] != 1
					v["cantidad"] -= 1
					$scope.total -= v["precio"]
				else
					$scope.total -= v["precio"]
					$scope.venta.operacionitems_attributes.splice(i,1)
		$scope.no_hay_items = true if $scope.venta.operacionitems_attributes.length == 0

	$scope.$on '$locationChangeStart', (event) ->
		if !$scope.no_hay_items
			respuesta = confirm("Desea descartar la orden de venta?")
			event.preventDefault() if !respuesta

	$scope.confirmar_venta = () ->
		$scope.venta.$update()
		.then ->
			$scope.no_hay_items = true
			$location.path('/ventas')
		.catch (err) ->
			alert(err)
		console.log($scope.venta)