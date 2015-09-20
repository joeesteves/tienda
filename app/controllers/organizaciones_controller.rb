class OrganizacionesController < ApplicationController
	before_action :set_organizacion, only: [:show, :update, :destroy]

	def index
		render json: Organizacion.order(:nombre)
	end

	def show
		render json: @organizacion
	end
	def create
		organizacion = Organizacion.new(organizacion_params)
		if organizacion.save
			render json: organizacion
		else
			render json: organizacion.errors.full_messages.to_json, status: 422
		end
	end

	def update
		if @organizacion.update(organizacion_params)
			render json: @organizacion
		end
	end

	def destroy
		if @organizacion.destroy
			head :no_content
		end
	end

private

	def set_organizacion
		@organizacion = Organizacion.find(params[:id])
	end

	def organizacion_params
		params.require(:organizacion).permit(:nombre, :id_fiscal, :email, :telefono, :desc)
	end

end