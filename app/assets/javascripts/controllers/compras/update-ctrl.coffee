angular.module 'Tienda'
.controller 'ComprasUpdateController', (Compra, Producto, Shared, $scope, $location, $routeParams) ->
	$scope.es_nuevo = false
	$scope.no_hay_items = false
	$scope.cant_prod = {}	
	Compra.get({id: $routeParams.id}).$promise
	.then (data) ->
		$scope.op = data
		$scope.op.fecha = new Date()	
		$scope.op.total = parseFloat($scope.op.total)
		$scope.organizaciones = data.organizacion
		Shared.actualizar_stock($scope)
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
	

	# $scope.confirmar_operacion = () ->
	# 	$scope.op.$update()
	# 	.then ->
	# 		$scope.no_hay_items = true
	# 		$location.path('/ops')
	# 	.catch (err) ->
	# 		alert(err)
	# 	console.log($scope.op)



	
	# $scope.actualizar_stock_ops()
	# console.log(Shared.actualizar_stock_ops)

	# $scope.actualizar_stock_ops = ->
	# 	angular.forEach $scope.op.operacionitems, (v) ->
	# 		$scope.cant_prod[v.producto.id] = v.cantidad

# 	cantidad_items = 0
	# 	angular.forEach $scope.op.operacionitems, (v) ->
	# 		if v.producto.id == producto.id && v["_destroy"] != true  
	# 			v.cantidad -= 1
	# 			v["_destroy"] = v.cantidad == 0
	# 		cantidad_items += 1 if !v["_destroy"]
	# 		$scope.cant_prod[producto.id] = v.cantidad
	# 	$scope.no_hay_items = true if cantidad_items == 0
	# 	$scope.editar_precio()
	# 	try
	# 		puc = $scope.precios[producto.id].puc
	# 	catch
	# 		puc = 0
	# 	producto_en_lista = false
	# 	angular.forEach $scope.op.operacionitems, (v,i) ->
	# 		if v.producto.id == producto.id
	# 			v.cantidad += 1
	# 			producto_en_lista = true
	# 			v["_destroy"] = false
	# 			$scope.cant_prod[producto.id] = v.cantidad 
	# 	if producto_en_lista == false
	# 		nuevo_item = {"producto": {"id": producto.id, "nombre": producto.nombre}, "cantidad": 1, "precio": puc }
	# 		$scope.op.operacionitems.push(nuevo_item)			# $scope.op.total += parseFloat(nuevo_item.precio)
	# 		$scope.cant_prod[producto.id] = 1
	# 	$scope.no_hay_items = false
	# 	$scope.editar_precio()