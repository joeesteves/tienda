class Producto < ActiveRecord::Base
  belongs_to :organizacion
  def as_json(options = nil)
		super (options || { include: :organizacion })
end
end