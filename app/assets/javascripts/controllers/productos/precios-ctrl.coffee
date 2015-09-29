angular.module 'Tienda' 
.controller 'ProductosPreciosController', (Producto, $scope, $sanitize) ->
	$scope.productos = Producto.precios()
	$scope.actualiza_margen = (producto)->
		if !(new RegExp(/^\d{1,2}(\.\d{1,3})?$/).test(producto.margen))
			producto.margen = 0 
			return alert('El margen debe ser entre 0 y 1, el separador de decimales es un .')
		if producto.margen != producto.margen_original
			producto.actualizando = true
			Producto.update({id: producto.id}, {producto: {margen: producto.margen}}).$promise
			.then ->
				producto.actualizando = false
				producto.margen_original = producto.margen
				producto.precio = producto.margen * producto.puc
			.catch ->
				alert('error carajo!')

