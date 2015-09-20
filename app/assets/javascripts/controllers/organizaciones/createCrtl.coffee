angular.module 'Tienda'
.controller 'OrganizacionesCreateController', (Organizacion, $scope, $location) ->
	$scope.organizacion = new Organizacion()
	$scope.guardar = () ->
		$scope.organizacion.$save()
		.then ->
			$location.path('/organizaciones')
		.catch (error) ->
			alert(error['statusText'])

