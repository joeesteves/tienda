angular.module 'Tienda'
.controller 'ComprasCreateController', (Compra, Producto, Organizacion, Shared, $scope, $location) ->
	$scope.es_nuevo = true
	$scope.no_hay_items = true
	$scope.op = new Compra()
	$scope.op.fecha = new Date()
	$scope.op.operacionitems = []
	$scope.op.total = 0.00
	$scope.cant_prod = {}
	Organizacion.query().$promise.then (data) ->
		$scope.organizaciones = data 
	Producto.query().$promise.then (data) ->
		$scope.productos = data
	$scope.precios = Producto.precios()
	
	$scope.agregar_item = (producto) ->
		Shared.agregar_item($scope, producto)

	$scope.restar_item = (producto) ->
		Shared.restar_item($scope, producto)
	
	$scope.editar_precio = ->
		Shared.editar_precio($scope)

	$scope.confirmar_operacion = ->
		Shared.confirmar_operacion($scope)

	$scope.$on '$locationChangeStart', (event) ->
		Shared.descartar_form($scope, event)

			
		# try
		# 	puc = $scope.precios[producto.id].puc
		# catch
		# 	puc = 0
		# producto_en_lista = false
		# angular.forEach $scope.compra.operacionitems, (v,i) ->
		# 	importe = v.cantidad * v.precio
		# 	$scope.compra.total += importe
		# 	if v.producto.id == producto.id
		# 		v.cantidad += 1
		# 		$scope.cant_prod_en_compra[producto.id] = v.cantidad
		# 		producto_en_lista = true
		# if producto_en_lista == false
		# 	nuevo_item = {"producto": {"id": producto.id, "nombre": producto.nombre}, "cantidad": 1, "precio": puc}
		# 	$scope.compra.operacionitems.push(nuevo_item)
		# 	$scope.cant_prod_en_compra[producto.id] = 1
		# 	$scope.compra.total += parseFloat(nuevo_item.precio)
		# $scope.no_hay_items = false
		# $scope.compra.organizacion_id = producto.organizacion_id if $scope.compra.operacionitems.length == 1



		# 	angular.forEach $scope.compra.operacionitems, (v,i) ->
		# 	if v.producto.id == producto.id
		# 		if v.cantidad != 1
		# 			v.cantidad -= 1
		# 			$scope.cant_prod_en_compra[producto.id] = v.cantidad
		# 			$scope.compra.total -= parseFloat(v.precio)
		# 		else
		# 			$scope.compra.total -= parseFloat(v.precio)
		# 			$scope.compra.operacionitems.splice(i,1)
		# 			$scope.cant_prod_en_compra[producto.id] = 0
		# $scope.no_hay_items = true if $scope.compra.operacionitems.length == 0

		# 	$scope.confirmar_operacion = () ->
		# $scope.compra.$save()
		# .then ->
		# 	$scope.no_hay_items = true
		# 	$location.path('/compras')
		# .catch (err) ->
		# 	console.log(err)
