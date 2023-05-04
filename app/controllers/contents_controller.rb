class ContentsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_project_id
  before_action :set_content,  only: [:edit, :update, :destroy, :show]
  before_action :set_q, only: [:index, :search]
  #before_action :admin_required, except: [:index, :show]
  

  def index
    @contents = Content.where(project_id: @project_id)
    @categories = Category.where(project_id: @project_id)
  end

  def new
    @content = Content.new
  end

  def show
  end

  def create
    @content = Content.new(content_params)
    @content.project_id = @project_id
    if @content.save
      flash[:notice] = "新規作成に成功しました"
      redirect_to contents_path
    else
      flash[:alert] = "エラーを確認してください"
      render 'new'
    end
  end

  def edit
  end

  def update
    if @content.update(content_params)
      flash[:notice] = "編集内容を保存しました"
      redirect_to contents_path
    else
      flash[:alert] = "エラーを確認してください"
      render 'edit'
    end
  end


  def destroy
    @content.destroy
    flash[:notice] = "カテゴリーを削除しました"
    redirect_to contents_path
  end

  def search
    @results = @q.result.where(project_id: @project_id)
  end

  private

  def set_project_id
    @project_id = current_user&.project_id || current_admin&.project_id
  end

  def content_params
    params.require(:content).permit(:title, :about, :category_id, :image, :description, :text, :video, :youtube_url, :project_id, :admin_id)
  end

  def set_content
    @content = Content.find(params[:id])
  end

  def set_q
    @q = Content.ransack(params[:q])
  end

  def admin_required
    unless current_user.admin? || current_admin.admin?
      flash[:alert] = "管理者権限が必要です"
      redirect_to root_path
    end
  end

end
