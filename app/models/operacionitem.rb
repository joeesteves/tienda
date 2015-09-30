class Operacionitem < ActiveRecord::Base
 	require 'csv'
  belongs_to :operacion
 	belongs_to :producto
  accepts_nested_attributes_for :producto

  def self.to_csv_ventas(options = {})
  	precios = Producto.precios
  	attributes = %w(fecha producto organizacion cantidad costo a_pagar precio_venta importe_vendido margen)
		CSV.generate(options) do |csv|
			csv << attributes
			all.each do |item|
				puc = precios[item.producto_id.to_s]['puc'].to_f
				importe_a_pagar = puc * item.cantidad
				importe_vendido = item.precio * item.cantidad
				margen = importe_vendido - importe_a_pagar
				csv << [item.operacion.fecha.strftime('%d/%m/%Y'), item.producto.nombre, item.producto.organizacion.nombre, item.cantidad, puc, importe_a_pagar, item.precio, importe_vendido, margen]
			end
		end
	end
	 def self.to_csv_compras(options = {})
  	precios = Producto.precios
  	attributes = %w(fecha producto organizacion cantidad precio importe puc)
		CSV.generate(options) do |csv|
			csv << attributes
			all.each do |item|
				importe_vendido = item.precio * item.cantidad
				puc = precios[item.producto_id.to_s]['puc'].to_f
				csv << [item.operacion.fecha.strftime('%d/%m/%Y'), item.producto.nombre, item.producto.organizacion.nombre, item.cantidad, item.precio, importe_vendido, puc]
			end
		end
	end
end
