require 'test_helper'

class ComprasTest < ActionDispatch::IntegrationTest
	test "crear una operacion de tipo compra" do
		compra = Operaciontipo.create(nombre: "compra")
		operacion = {operacion: {fecha: Date.today,  desc: "primera compra", operacionitems_attributes: [
				{producto_id: Producto.first.id, cantidad: 1.2, precio: 1.9},
				{producto_id: Producto.first.id, cantidad: 1.2, precio: 1.9}
				]}}

		post '/operaciones', operacion.to_json, encabezado_con_contenido
		
		puts parse_json(response)[:operacionitems]

		
		assert_response :success
	end

	test "no permite crear una compra sin 1 regitsro" do
		compra = Operaciontipo.create(nombre: "compra")
		operacion = {fecha: Date.today, desc: "primera compra"}
		post '/operaciones', {operacion: operacion}.to_json, encabezado_con_contenido
		puts parse_json(response)
		assert_response(422)
	end

	# test "permite crear una compra con 2 registros validos" do
	# end

	# test "no permite crear una compra con algun registro invalido" do
	# end

	# test "listar las compras" do
	# end


end
