# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

pagotipos = Pagotipo.create([
	{nombre: "Efectivo", factor: 1},
	{nombre: "Tarjeta", factor: 1.1}
	])
operaciontipos = Operaciontipo.create([
	{nombre: "venta"},
	{nombre: "compra"}
	])
