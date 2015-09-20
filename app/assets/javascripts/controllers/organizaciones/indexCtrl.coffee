angular.module 'Tienda' 
.controller 'OrganizacionesIndexController', (Organizacion, $scope) ->
	$scope.organizaciones = Organizacion.query()
	$scope.pre_borrar = (objeto_a_borrar) ->
		$scope.objeto_a_borrar = objeto_a_borrar
	$scope.borrar = () ->
		$scope.objeto_a_borrar.$remove()
		.then ->
			$scope.organizaciones = Organizacion.query()