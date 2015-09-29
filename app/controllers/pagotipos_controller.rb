class PagotiposController < ApplicationController
	before_action :set_pagotipo, only: [:show, :update, :destroy]

	def index
		render json: Pagotipo.all.as_json
	end

	def show
		render @pagotipo
	end
	
	def create
		@pagotipo = Pagotipo.new(pagotipo_params)
		if @pagotipo.save
			render json: @pagotipo
		end
	
	end
	
	def update
		if @pagotipo.update(pagotipo_params)
			render json: @pagotipo
		end
	end

	def destroy
		if @pagotipo.destroy
			head :no_content
		end
	end


private
	def set_pagotipo
		@pagotipo = Pagotipo.find(params[:id])
	end

	def pagotipo_params
		params.require(:pagotipo).permit(:nombre, :factor)
	end

end