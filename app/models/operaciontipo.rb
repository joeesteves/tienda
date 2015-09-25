class Operaciontipo < ActiveRecord::Base
	has_many :operaciones
	validates :nombre, uniqueness: true
end
