class ProductsController < ApplicationController

  def index
    @products = Product.all.order(created_at: :desc)
  end

  def show
		@product = Product.find params[:id]
		@review = Review.new
		@reviews = @product.reviews
		@AveRates = aver_rates
  end

  def aver_rates
		@ratelngth = 0
		ratingSum = @product.reviews.reduce(0) { |sum, review| 
			@ratelngth = @ratelngth + 1
			sum + review.rating 
		}
		if (@ratelngth > 0)
			ratingSum / @ratelngth
		end  
  end 
 
end
