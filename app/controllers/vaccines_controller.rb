class VaccinesController < ApplicationController
  def create
    @vaccine = Vaccine.new(name: params[:name], slug: params[:slug])

    if @vaccine.save
      render json: { message: 'Vaccine was successfully created.', vaccine_id: @vaccine.id }, status: :ok
    else
      render json: { message: @vaccine.errors.full_messages }, status: :unprocessable_entity
    end
  end
end
