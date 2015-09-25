class ProductosController < ApplicationController
	before_action :set_producto, only: [:show, :update, :destroy]

	def index
		render json: Producto.order(:nombre).as_json(include: {organizacion: {only: :nombre}})
	end

	def show
		render json: @producto
	end

	def create
		@producto = Producto.new(producto_params)
		if @producto.save
			render json: @producto
		end
	end

	def update
		if @producto.update(producto_params)
			render json: @producto
		end
	end

	def destroy
		if @producto.destroy
			head :no_content
		end 
	end


private

	def set_producto
		@producto = Producto.find(params[:id])
	end
	
	def producto_params
		params.require(:producto).permit(:nombre, :organizacion_id, :image, :desc)
	end

end