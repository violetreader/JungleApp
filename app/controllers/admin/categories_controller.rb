class Admin::CategoriesController < ApplicationController

  def index
    @categories = Category.order(id: :desc).all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to [:admin, :categories], notice: 'Category created!'
    else
      render :new
    end
  end

  def show
    @category = Category.find(params[:id])
  end

private
# everything under private is only accesible to ths file so it should only be needed for this file

# code doesnt work if below is included
  def category_params
    params.require(:category).permit(
      :name
    )
  end

end
