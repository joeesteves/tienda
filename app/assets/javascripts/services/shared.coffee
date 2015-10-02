angular.module 'Tienda'
.factory 'Shared', ($location) ->
	editar_precio: (scope) ->
		scope.op.total = 0
		angular.forEach scope.op.operacionitems, (item) ->
			importe = item.cantidad * item.precio
			scope.op.total += importe
		parseFloat(scope.op.total.toFixed(2))

	actualizar_stock: (scope) ->
		angular.forEach scope.op.operacionitems, (item) ->
			scope.cant_prod[item.producto.id] = item.cantidad

	confirmar_operacion: (scope) ->
		if @.es_create()
			accion = "$save"
		else
			accion = "$update"
		controller = @.get_controller()
		scope.op.pago = scope.op.total if controller == "ventas" && scope.op.reserva != true 
		scope.op[accion]()
		.then ->
			scope.no_hay_items = true
			$location.path('/' + controller)
		.catch (err) ->
			console.log(err)

	restar_item: (scope, producto) ->
		cantidad_items = 0
		angular.forEach scope.op.operacionitems, (item) ->
			if item.producto.id == producto.id && item["_destroy"] != true  
				item.cantidad -= 1
				item["_destroy"] = item.cantidad == 0
			cantidad_items += 1 if !item["_destroy"]				
			scope.cant_prod[producto.id] = item.cantidad
		scope.no_hay_items = true if cantidad_items == 0
		scope.editar_precio()

	agregar_item: (scope, producto) ->
		cantidad_items = 0
		factor_original = scope.op.factor_original || 1
		puc = @.set_puc(scope.precios, producto.id, factor_original)
		producto_en_lista = false
		angular.forEach scope.op.operacionitems, (item) ->
			cantidad_items += 1 if !item["_destroy"]
			if item.producto.id == producto.id
				item.cantidad += 1
				producto_en_lista = true
				item["_destroy"] = false
				scope.cant_prod[producto.id] = item.cantidad 
		if producto_en_lista == false
			cantidad_items += 1
			nuevo_item = {"producto": {"id": producto.id, "nombre": producto.nombre}, "cantidad": 1, "precio": puc }
			scope.op.operacionitems.push(nuevo_item)
			scope.cant_prod[producto.id] = 1
		scope.no_hay_items = false
		scope.editar_precio()
		scope.op.organizacion_id = producto.organizacion_id if cantidad_items == 1

	set_puc: (precios, producto_id, factor_original)->
		margen = if @.get_controller() == 'ventas' then precios[producto_id].margen else 1 
		try
			puc = precios[producto_id].puc * factor_original * margen
		catch
			puc = 0
		parseFloat(puc.toFixed(2))
	
	actualizar_precio_pagotipo: (scope, pagotipo) ->
		angular.forEach scope.op.operacionitems, (item) ->
			item.precio = parseFloat((item.precio * pagotipo.factor / scope.op.factor_original).toFixed(2))
		scope.op.factor_original =  pagotipo.factor
		scope.editar_precio()

	es_create: ->
		new RegExp("/new").test($location.path())

	get_controller: () ->
		$location.path().match(/^\/(\w+)\/?/)[1]

	descartar_form: (scope, event) ->
		if !scope.no_hay_items
			respuesta = confirm("Desea descartar la orden de venta?")
			event.preventDefault() if !respuesta