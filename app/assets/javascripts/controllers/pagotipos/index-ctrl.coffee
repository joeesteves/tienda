angular.module 'Tienda' 
.controller 'PagotiposController', (Pagotipo, $scope) ->
	$scope.pagotipos = Pagotipo.query()
	$scope.actualiza_factor = (pagotipo)->
		if !(new RegExp(/^\d{1,2}(\.\d{1,3})?$/).test(pagotipo.factor))
			pagotipo.factor = 1 
			return alert('El margen mayor 1, el separador de decimales es un .')
		if pagotipo.factor != pagotipo.factor_original
			pagotipo.actualizando = true
			Pagotipo.update({id: pagotipo.id},{pagotipo: {factor: pagotipo.factor}}).$promise
			.then ->
				pagotipo.actualizando = false
				pagotipo.factor_original = pagotipo.factor
			.catch ->
				alert('error carajo!')

