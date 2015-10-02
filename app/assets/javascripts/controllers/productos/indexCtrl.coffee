angular.module 'Tienda' 
.controller 'ProductosIndexController', (Producto, $scope, $sanitize) ->
	Producto.query().$promise.then (data) ->
		$scope.productos = data
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
		
	$scope.tiene_desc = (producto) ->
		if [null, undefined, ''].indexOf(producto.desc) == -1
			true
		else
			false