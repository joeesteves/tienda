angular.module 'Tienda' 
.controller 'ProductosPreciosController', (Producto, $scope, $sanitize) ->
	# Producto.precios().$promise.then (data) ->
	# 	$scope.productos = data
	# console.log(Producto.precios())
	$scope.productos = Producto.precios()