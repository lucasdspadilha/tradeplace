class Address < ApplicationRecord
    belongs_to :user  # Garantir que o endereço sempre tenha um usuário associado
  
    validates :street, :number, :neighborhood, :city, :user, presence: true
    validates :cep, presence: true, format: { with: /\A\d{5}-\d{3}\z/, message: "não é válido" } # Validação do formato de CEP
  end
  