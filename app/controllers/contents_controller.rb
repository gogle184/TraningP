class ContentsController < ApplicationController
  def index
    @contents = Content.all
    @categories = Category.all
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
    def content_params
      params.require(:content).permit(:title, :about, :category_id, :image, :description, :text, :category_id)
    end
end
