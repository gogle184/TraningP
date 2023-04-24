class ContentsController < ApplicationController
  def index
    @contents = Content.all
  end

  def new
    @content = Content.new
  end

  def create
    @content = Content.new(content_params)
    @content.user_id = current_user.id
    if @content.save
      redirect_to contents_path
    else
      flash.now[:error] = @content.errors.full_messages.join(", ")
      render 'new'
    end
  end

  def destroy
    @contents.destroy
    redirect_to contents_path
  end

  private
    def content_params
      params.require(:content).permit(:title, :about, :category_id, :image, :description)
    end
end
