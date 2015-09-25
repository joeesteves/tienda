class Operacion < ActiveRecord::Base
	belongs_to :operaciontipo
	has_many :operacionitems 
	accepts_nested_attributes_for :operacionitems, allow_destroy: true
	validates :operacionitems, presence: {message: '- Debe habar al menos un item para la operación'}


	def al_menos_un_item
		errors.add(:base, "debe haber al menos un item") if operacionitems.blank?
	end 

end
