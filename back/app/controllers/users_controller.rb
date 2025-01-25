class UsersController < ApplicationController
  def show
    user = User.includes(:address).find(params[:id])

    if user
      render json: { 
        success: true, 
        user: {
          id: user.id,
          name: user.name,
          email: user.email,
          phone: user.phone,
          user_type: user.user_type,
          address: user.address ? {
            id: user.address.id,
            street: user.address.street,
            number: user.address.number,
            neighborhood: user.address.neighborhood,
            cep: user.address.cep,
            complement: user.address.complement,
            city: user.address.city
          } : nil
        }
      }, status: :ok
    else
      render json: { success: false, message: 'Usuário não encontrado' }, status: :not_found
    end
  end

  # Criação de usuário
  def create
    user = User.new(user_params)

    if user.save
      render json: { success: true, message: "Usuário criado com sucesso!", user: user }, status: :created
    else
      render json: { success: false, message: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # Edição de usuário
  def update
    user = User.find_by(id: params[:id])

    if user.update(user_params)
      render json: { success: true, message: "Usuário atualizado com sucesso!", user: user }
    else
      render json: { success: false, message: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :phone, :address_id, :user_type)
  end
end
