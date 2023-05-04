class CategoriesController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_category, only: [:edit, :update, :destroy]
  before_action :set_project_id
  #before_action :admin_required, except: [:index, :show]

  def index
    @category = Category.new
    @categories = Category.where(project_id: @project_id)
  end

  def create
    @category = Category.new(category_params)
    @category.project_id = @project_id
    @category.admin_id = current_admin.id
    if @category.save
      flash[:notice] = "新規作成に成功しました"
      redirect_to categories_path
    else
      flash[:alert] = "エラーを確認してください"
      @categories = Category.where(project_id: @project_id)
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

  def set_project_id
    @project_id = current_user&.project_id || current_admin&.project_id
  end

  def admin_required
    unless current_user.admin?
      flash[:alert] = "管理者権限が必要です"
      redirect_to root_path
    end
  end
end
