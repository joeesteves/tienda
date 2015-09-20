require 'test_helper'

class ProductosTest < ActionDispatch::IntegrationTest
	test "crear productos con info valida" do
		producto = Producto.new(
			nombre: 'la pochola', organizacion: organizaciones(:fratelli), desc: 'medidas etc etc'
		)
		post '/productos', {producto: producto}.to_json, encabezado_con_contenido

		assert_response :success
		resp = parse_json(response)
		assert_equal producto.nombre, resp[:nombre] 
	end

	test "listar productos" do
		get '/productos', {}, encabezado
		assert_response :success
		resp = parse_json(response)
		assert_equal 2, resp.size
		assert_equal 'Alalala', resp[0][:nombre]
	end

	test "editar productos" do
		producto = productos(:alalala)
		nuevo_nombre = "producto editado"
		producto.nombre = nuevo_nombre
		put "/productos/#{productos(:alalala).id}", {producto: producto}.to_json, encabezado_con_contenido
		assert_response :success
		get "/productos/#{producto.id}"
		producto = parse_json(response)
		assert_equal nuevo_nombre, producto[:nombre] 	
	end
end
