class ComprasController < ApplicationController
	before_action :set_compra, only: [:show, :update, :destroy]

	def index
		render json: Operacion.compras.order(:nombre)
	end

	def show
		render json: @compra
	end
	def create
		compra = Operacion.new(compra_params)
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
		params.require(:compra).permit(:fecha, :desc, :operaciontipo_id, operacionitems_attributes: [:id, :producto_id, :cantidad, :precio, :_destroy])
	end

end