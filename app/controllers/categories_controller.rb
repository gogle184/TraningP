class CategoriesController < ApplicationController
  before_action :set_category, only: [:edit, :update, :destroy]

  def index
    @category = Category.new
    @categories = Category.where(admin_id: current_user.admin_id)
  end

  def create
    @category = Category.new(category_params)
    @category.admin_id = current_user.admin_id
    if @category.save
      redirect_to categories_path
    else
      render 'index'
    end
  end

  def edit
  end

  def update
    if @category.update(category_params)
      redirect_to categories_path
    else
      render 'edit'
    end
  end

  def destroy
    @category.destroy
    redirect_to categories_path
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:title, :description)
  end
end
