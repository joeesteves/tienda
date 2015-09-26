class OperacionesController < ApplicationController
	before_action :set_operacion, only: [:show, :update, :destroy]

	def index
		render json: Operacion.order(:nombre).as_json
	end

	def show
		render json: @operacion
		end

	def create
		operacion = Operacion.new(operacion_params)
		if operacion.save
			render json: operacion.as_json(include: :operacionitems)
		else
			render json: operacion.errors.full_messages.to_json, status: 422
		end
	end

	def update
		if @operacion.update(operacion_params)
			render json: @operacion
		end
	end

	def destroy
		if @operacion.destroy
			head :no_content
		end
	end

private

	def set_operacion
		@operacion = Operacion.find(params[:id])
	end

	def operacion_params
		unless params[:operacion][:operacionitems].blank?
			params[:operacion][:operacionitems_attributes] = params[:operacion][:operacionitems]
			params[:operacion].delete("operacionitems")
			params[:operacion][:operacionitems_attributes].each do |item|
				item[:producto_id] = item[:producto][:id]
				item.delete("producto")
			end
			params.require(:operacion).permit(:fecha, :desc, :operaciontipo_id, operacionitems_attributes: [:id, :producto_id, :cantidad, :precio, :_destroy])
		end
	end

end