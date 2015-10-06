angular.module 'Tienda' 
.controller 'ProductosIndexController', (Producto, $scope, $timeout) ->
	$scope.mostrar = 12
	$('#mostrar_todos').tooltip()
	Producto.query().$promise.then (data) ->
		$scope.productos = data
		$timeout ->
			$('.producto_nombre').tooltip()
		$scope.$on '$destroy', ->
			$('.producto_nombre').tooltip('destroy')
		angular.forEach $scope.productos, (producto) ->
			producto.tab_activa = 'home' 
	Producto.precios().$promise.then (data) ->
		$scope.precios = data
	$scope.pre_borrar = (objeto_a_borrar) ->
		$scope.objeto_a_borrar = objeto_a_borrar
	$scope.borrar = () ->
		$scope.objeto_a_borrar.$remove()
		.then ->
			$scope.productos = Producto.query()
	$scope.tiene_imagen = (producto) ->
		if [null, undefined, ''].indexOf(producto.image) == -1
			true
		else
			false	
	$scope.tiene_info = (producto) ->
		if [null, undefined, ''].indexOf(producto.desc) == -1
			true
		else
			false
	$scope.actualizarTooltip = () ->
		$timeout ->
			$('.producto_nombre').tooltip('destroy')
			$('.producto_nombre').tooltip()