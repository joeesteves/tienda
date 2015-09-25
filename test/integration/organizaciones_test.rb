require 'test_helper'

class OrganizacionesTest < ActionDispatch::IntegrationTest
  test "crear organzaciones con info valida" do
  	organizacion = Organizacion.new(
  		nombre: 'la pochola', id_fiscal: '20-16123456-0', email: 'la_pocha@gmail.com', telefono: '555-456', desc: 'buenas macetas'
  	)
  	post '/organizaciones', {organizacion: organizacion}.to_json, encabezado_con_contenido

  	assert_response :success
  	resp = parse_json(response)
  	assert_equal organizacion.nombre, resp[:nombre] 
  end
  # test "no crear organzaciones con info invalida" do
  # 	organizacion = Organizacion.new(
  # 		nombre: 'la pochola', id_fiscal: '20-16123456-0', email: 'la_pocha@gmai_com', telefono: '555-456', desc: 'buenas macetas'
  # 	)
  # 	post '/organizaciones', {organizacion: organizacion}.to_json, encabezado_con_contenido

  # 	assert_response(422)
  
  # end


  test "listar organizaciones" do
  	get '/organizaciones', {}, encabezado
  	assert_response :success
  	resp = parse_json(response)
  	assert_equal 4, resp.size
  	assert_equal 'Cuarto', resp[0][:nombre]
  end

  test "editar organizaciones" do
	 	organizacion = organizaciones(:fratelli)
  	nuevo_nombre = "Fratelli Hnos."
  	organizacion.nombre = nuevo_nombre
  	put "/organizaciones/#{organizaciones(:fratelli).id}", {organizacion: organizacion}.to_json, encabezado_con_contenido
  	assert_response :success
  	get "/organizaciones/#{organizacion.id}"
  	organizacion = parse_json(response)
  	assert_equal nuevo_nombre, organizacion[:nombre]
  	
  end

end
