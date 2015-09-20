angular.module 'Tienda'
.controller 'OrganizacionesUpdateController', (Organizacion, $scope, $location, $routeParams) ->
	Organizacion.get {id: $routeParams.id}, (data) ->
		$scope.organizacion = data
	$scope.guardar = () ->
		$scope.organizacion.$update()
		.then ->
			$location.path('/organizaciones')
		.catch (error) ->
			alert(error['statusText'])

