angular.module 'Tienda'
.factory 'Shared', ($location) ->
	editar_precio: (scope) ->
		scope.op.total = 0
		angular.forEach scope.op.operacionitems, (v,i) ->
			importe = v.cantidad * v.precio
			scope.op.total += importe
		scope.op.total

	actualizar_stock: (scope) ->
		angular.forEach scope.op.operacionitems, (v,i) ->
			scope.cant_prod[v.producto.id] = v.cantidad

	confirmar_operacion: (scope) ->
		if @.es_create_controller()
			accion = "$save"
		else
			accion = "$update"
		scope.op[accion]()
		.then ->
			scope.no_hay_items = true
			$location.path('/compras')
		.catch (err) ->
			alert(err)

	restar_item: (scope, producto) ->
		cantidad_items = 0
		angular.forEach scope.op.operacionitems, (v) ->
			if v.producto.id == producto.id && v["_destroy"] != true  
				v.cantidad -= 1
				v["_destroy"] = v.cantidad == 0
			cantidad_items += 1 if !v["_destroy"]				
			scope.cant_prod[producto.id] = v.cantidad
		scope.no_hay_items = true if cantidad_items == 0
		scope.editar_precio()

	agregar_item: (scope, producto) ->
		cantidad_items = 0
		puc = @.set_puc(scope.precios, producto.id)
		producto_en_lista = false
		angular.forEach scope.op.operacionitems, (v) ->
			cantidad_items += 1 if !v["_destroy"]
			if v.producto.id == producto.id
				v.cantidad += 1
				producto_en_lista = true
				v["_destroy"] = false
				scope.cant_prod[producto.id] = v.cantidad 
		if producto_en_lista == false
			cantidad_items += 1
			nuevo_item = {"producto": {"id": producto.id, "nombre": producto.nombre}, "cantidad": 1, "precio": puc }
			scope.op.operacionitems.push(nuevo_item)
			scope.cant_prod[producto.id] = 1
		scope.no_hay_items = false
		scope.editar_precio()
		scope.op.organizacion_id = producto.organizacion_id if cantidad_items == 1

	set_puc: (precios, producto_id)->
		try
			puc = precios[producto_id].puc
		catch
			puc = 0
		puc

	es_create_controller: ->
		new RegExp("/new").test($location.path())
  	
		

