class CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_category, only: [:edit, :update, :destroy]
  before_action :admin_required, except: [:index, :show]

  def index
    @category = Category.new
    @categories = Category.where(admin_id: current_user.admin_id)
  end

  def create
    @category = Category.new(category_params)
    @category.admin_id = current_user.admin_id
    @category.user_id = current_user.id
    if @category.save
      flash[:notice] = "新規作成に成功しました"
      redirect_to categories_path
    else
      flash[:alert] = "エラーを確認してください"
      @categories = Category.where(admin_id: current_user.admin_id)
      render 'index'
    end
  end

  def edit
  end

  def update
    if @category.update(category_params)
      flash[:notice] = "編集を反映しました"
      redirect_to categories_path
    else
      flash[:alert] = "エラーを確認してください"
      render 'edit'
    end
  end

  def destroy
    @category.destroy
    flash[:notice] = "カテゴリーを削除しました"
    redirect_to categories_path
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:title, :description)
  end

  def admin_required
    unless current_user.admin?
      flash[:alert] = "管理者権限が必要です"
      redirect_to root_path
    end
  end
end
