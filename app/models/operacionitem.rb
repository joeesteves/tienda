class Operacionitem < ActiveRecord::Base
  belongs_to :operacion
  belongs_to :producto
end
