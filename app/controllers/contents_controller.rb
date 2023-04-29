class ContentsController < ApplicationController
  before_action :set_admin_id
  

  def index
    @contents = Content.where(admin_id: current_user.admin_id)
    @categories = Category.where(admin_id: current_user.admin_id)
  end

  def new
    @content = Content.new
  end

  def show
    @content = Content.find(params[:id])
  end

  def create
    @content = Content.new(content_params)
    @content.user_id = current_user.id
    @content.admin_id = @admin_id

    if @content.save
      redirect_to contents_path
    else
      Rails.logger.error @content.errors.inspect
      flash.now[:error] = @content.errors.full_messages.join(", ")
      render 'new'
    end
  end

  def destroy
    @content = Content.find(params[:id])
    @content.destroy
    redirect_to contents_path, notice: 'コンテンツが削除されました'
  end

  private

  def set_admin_id
    @admin_id = current_user.admin_id
    
  end

  def content_params
    params.require(:content).permit(:title, :about, :category_id, :image, :description, :text, :video)
  end

end
