class Producto < ActiveRecord::Base
  belongs_to :organizacion
  has_many :operacionitems

 	def self.precios
		lista = {} 			
	 	Operacionitem.find_by_sql("select a.id, c.fuc, a.producto_id, c.nombre, a.precio, c.margen from operacionitems as a join operaciones as b on a.operacion_id = b.id join (select max(b.fecha) as fuc, a.producto_id as pmax_id , c.nombre, c.margen from operacionitems as a join operaciones as b on a.operacion_id = b.id inner join productos as c on a.producto_id = c.id where b.operaciontipo_id = #{Operaciontipo.find_by_nombre('compra').id} group by a.producto_id, c.nombre, c.margen ) as c on (a.producto_id = c.pmax_id and b.fecha = c.fuc)").map {|p| lista[p.producto_id] = {id: p.producto_id, nombre: p.nombre, puc: p.precio, fuc: p.fuc, margen: p.margen, precio: p.precio * p.margen }}
	 	lista.as_json
 	end

  def as_json(options = nil)
		super (options || { include: {organizacion: {only: :nombre}}})
	end
end
