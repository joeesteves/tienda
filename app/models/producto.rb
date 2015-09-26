class Producto < ActiveRecord::Base
  belongs_to :organizacion
  has_many :operacionitems

  def as_json(options = nil)
		super (options || { include: {organizacion: {only: :nombre}}})
	end
end
