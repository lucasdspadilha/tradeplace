class FeedbackController < ApplicationController
    before_action :set_product, only: [:create]

    def create
      @feedback = @product.feedbacks.new(feedback_params)
      @feedback.user = current_user  
  
      if @feedback.save
        @product.update_rating_value!
        
        render json: @feedback, status: :created
      else
        render json: { error: @feedback.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    private
  
    def set_product
      @product = Product.find(params[:product_id])
    end
  
    def feedback_params
      params.require(:feedback).permit(:rating_value, :comment)
    end
end
  