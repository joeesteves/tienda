class ComprasController < ApplicationController
	before_action :set_compra, only: [:show, :update, :destroy]

	def index
		render json: Operacion.compras.order(:created_at)
	end

	def show
		render json: @compra
	end
	def create
		op_compra = Operaciontipo.find_by_nombre('compra')
		compra = op_compra.operaciones.new(compra_params)
		if compra.save
			render json: compra
		else
			render json: compra.errors.full_messages.to_json, status: 422
		end
	end

	def update
		if @compra.update(compra_params)
			render json: @compra
		end
	end

	def destroy
		if @compra.destroy
			head :no_content
		end
	end

private

	def set_compra
		@compra = Operacion.find(params[:id])
	end

	def compra_params
		# unless params[:operacion][:organizacion].blank?
		# 	params[:operacion][:organizacion_id] = params[:operacion][:organizacion][:id]
		# 	params[:operacion].delete("organizacion")
		# end
		unless params[:compra][:operacionitems].blank?
			params[:compra][:operacionitems_attributes] = params[:compra][:operacionitems]
			params[:compra].delete("operacionitems")
			params[:compra][:operacionitems_attributes].each do |item|
				item[:producto_id] = item[:producto][:id]
				item.delete("producto")
			end
		end
		params.require(:compra).permit(:fecha, :desc, :operaciontipo_id, :organizacion_id,
			operacionitems_attributes: [:id, :producto_id, :cantidad, :precio, :_destroy])
	end

end