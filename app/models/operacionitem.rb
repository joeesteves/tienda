class Operacionitem < ActiveRecord::Base
  belongs_to :operacion
 	belongs_to :producto
  accepts_nested_attributes_for :producto
end
