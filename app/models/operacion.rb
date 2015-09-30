class Operacion < ActiveRecord::Base
	belongs_to :operaciontipo
	belongs_to :organizacion
	belongs_to :pagotipo
	has_many :operacionitems, dependent: :destroy 
	accepts_nested_attributes_for :operacionitems, allow_destroy: true
	validates :operacionitems, presence: {message: '- Debe habar al menos un item para la operación'}

	# Scopes
	scope :ventas, -> {joins(:operaciontipo).where("operaciontipos.nombre = 'venta'")}
	scope :compras, -> {joins(:operaciontipo).where("operaciontipos.nombre = 'compra'")}

	def al_menos_un_item
		errors.add(:base, "debe haber al menos un item") if operacionitems.blank?
	end 

	def as_json(options = nil)
		super (options || { include: [{operacionitems: {except: [:created_at, :updated_at], include: :producto}}, :organizacion, :pagotipo]})
	end

	def self.exportar(operaciontipo)
		Operacionitem.joins(operacion: :operaciontipo, producto: :organizacion).where("operaciontipos.nombre = '#{operaciontipo}'")
	end

	
end
