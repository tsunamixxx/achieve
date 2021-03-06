class BlogsController < ApplicationController
  before_action :authenticate_user!

  # onlyにshowアクションを追加します。
  before_action :set_blog, only: [:show, :edit, :update, :destroy]

  def index
    @blogs = Blog.all
    # raise
  end

  # showアククションを定義します。入力フォームと一覧を表示するためインスタンスを2つ生成します。
  def show
    @comment = @blog.comments.build #Commentsモデルのblog_idレコードに値がセットされ、@commentにインスタンス変数として代入される
    @comments = @blog.comments
    
    Notification.find(params[:notification_id]).update(read: true) if params[:notification_id]
  end

  def new
    if params[:back]
      @blog = Blog.new(blogs_params)
    else
    @blog = Blog.new
    end
  end

  def create
    # Blog.create(blogs_params)
    # @blog = Blog.create(blogs_params)ではだめなのか？？
    @blog = Blog.new(blogs_params) #バリデーションが失敗して、render 'new'が実行された場合に変数を渡すことができるようにするためにインスタンス変数に代入している
    @blog.user_id = current_user.id
    if @blog.save
      redirect_to blogs_path, notice: "ブログを作成しました！"
      NoticeMailer.sendmail_blog(@blog).deliver
    else
      render 'new'
    end
  end

  def confirm
    @blog = Blog.new(blogs_params)
    render :new if @blog.invalid?
  end

  def edit
    # @blog = Blog.find(params[:id])
  end

  def update
    # @blog = Blog.find(params[:id])
    if @blog.update(blogs_params)
      redirect_to blogs_path, notice: "ブログを編集しました！"
    else
      render 'edit'
    end
  end

  def destroy
    # @blog = Blog.find(params[:id])
    @blog.destroy
    redirect_to blogs_path, notice: "ブログを削除しました！"
  end

  private
    def blogs_params
      params.require(:blog).permit(:title, :content)
    end

    def set_blog
      @blog = Blog.find(params[:id])
    end
end
