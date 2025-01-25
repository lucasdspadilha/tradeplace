class AddressesController < ApplicationController
    def create
      Rails.logger.debug "Address Params: #{address_params.inspect}"  
  
      @address = Address.new(address_params)
  
      if @address.save
        render json: @address, status: :created  
      else
        render json: @address.errors, status: :unprocessable_entity  
      end
    end
  
    def update
      @address = Address.find(params[:id])
  
      if @address.update(address_params)
        render json: @address, status: :ok  
      else
        render json: @address.errors, status: :unprocessable_entity  
      end
    end
  
    private
  
    def address_params
      params.require(:address).permit(:street, :number, :neighborhood, :cep, :complement, :city, :user_id)
    end
  end
  