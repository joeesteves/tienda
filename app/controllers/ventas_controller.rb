class VentasController < ApplicationController
	before_action :set_venta, only: [:show, :update, :destroy]

	def index
		render json: Operacion.ventas.order(:nombre)
	end

	def show
		render json: @venta
	end
	def create
		venta = Operacion.new(ventas_params)
		if venta.save
			render json: venta
		else
			render json: venta.errors.full_messages.to_json, status: 422
		end
	end

	def update
		if @venta.update(venta_params)
			render json: @venta
		end
	end

	def destroy
		if @venta.destroy
			head :no_content
		end
	end

private

	def set_venta
		@venta = Operacion.find(params[:id])
	end

	def ventas_params
		params.require(:venta).permit(:fecha, :desc, :operaciontipo_id, operacionitems_attributes: [:id, :producto_id, :cantidad, :precio, :_destroy])
	end

end