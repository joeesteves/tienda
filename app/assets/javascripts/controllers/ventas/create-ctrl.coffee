angular.module 'Tienda'
.controller 'VentasCreateController', (Venta, Producto, Pagotipo, $scope, $location) ->
	$scope.venta = new Venta()
	$scope.venta.fecha = new Date()	
	$scope.productos = Producto.query()
	$scope.no_hay_items = true
	$scope.venta.operacionitems = []
	$scope.focus_en_buscador = false
	$scope.venta.total = 0.00
	$scope.cant_prod_en_venta = {} # {id_delproducto: cantidad}
	$scope.precios = Producto.precios()
	$scope.pagotipos = Pagotipo.query()

	$scope.agregar_item = (producto) ->
		if $scope.precios[producto.id] == undefined
			precio = 0 
		else
			precio = $scope.precios[producto.id].precio
		producto_en_lista = false
		angular.forEach $scope.venta.operacionitems, (v,i) ->
			if v.producto.id == producto.id
				v.cantidad += 1
				$scope.cant_prod_en_venta[producto.id] = v.cantidad
				producto_en_lista = true
				$scope.venta.total += parseFloat(v.precio)
		if producto_en_lista == false
			nuevo_item = {"producto": {"id": producto.id, "nombre": producto.nombre}, "cantidad": 1, "precio": precio}
			$scope.venta.operacionitems.push(nuevo_item)
			$scope.cant_prod_en_venta[producto.id] = 1
			$scope.venta.total += nuevo_item.precio
		$scope.no_hay_items = false

	$scope.restar_item = (producto) ->
		angular.forEach $scope.venta.operacionitems, (v,i) ->
			if v.producto.id == producto.id
				if v.cantidad != 1
					v.cantidad -= 1
					$scope.cant_prod_en_venta[producto.id] = v.cantidad
					$scope.venta.total -= parseFloat(v["precio"])
				else
					$scope.venta.total -= parseFloat(v["precio"])
					$scope.venta.operacionitems.splice(i,1)
					$scope.cant_prod_en_venta[producto.id] = 0
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

	$scope.editar_precio = ->
		$scope.venta.total = 0
		angular.forEach $scope.venta.operacionitems, (v,i) ->
			importe = v.cantidad * v.precio
			$scope.venta.total += importe


			
