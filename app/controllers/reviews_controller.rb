class ReviewsController < ApplicationController
	before_filter :require_login

	def create
		product = Product.find(params[:product_id])
		review = product.reviews.create(review_params)

		# params[:review]
		# @review[:user] = current_user
		review.user_id = current_user.id
		if review.save
			redirect_to product
		else
			render product
		end
	end

	def destroy
		review = Review.find(params[:id])
		review.destroy
		redirect_to review.product
	end

		private

	def review_params
		params.require(:review).permit(:description, :rating)
	end

	def require_login
		redirect_to path_to_product unless current_user
	end
	def path_to_product
		product_path(id: params[:product_id])
	end

end
