class CommentsController < ApplicationController
  # コメントを保存、投稿するためのアクションです。
  def create
    # Blogをパラメータの値から探し出し,Blogに紐づくcommentsとしてbuildします。
    @comment = current_user.comments.build(comment_params)
    @blog = @comment.blog
    @notification = @comment.notifications.build(user_id: @blog.user.id )
    # クライアント要求に応じてフォーマットを変更
    respond_to do |format|
      if @comment.save
        format.html {redirect_to blog_path(@blog), notice: 'コメントを投稿しました！'}
        # JS形式でレスポンスを返します。
        format.js { render :index }
        unless @comment.blog.user_id == current_user.id
          Pusher.trigger("user_#{@comment.blog.user_id}_channel", 'comment_created', {
          message: 'あなたの作成したブログにコメントが付きました'
        })
        end
        Pusher.trigger("user_#{@comment.blog.user_id}_channel", 'notification_created', {
          unread_counts: Notification.where(user_id: @comment.blog.user.id, read: false).count
        })
      else
        format.html { render :new } # ここでのNewはどこに飛ぶのか？ Viewsのcomments内にNewファイルがない
      end
    end
  end

  def edit
    @comment = Comment.find(params[:id])
    @blog = @comment.blog
  end

  def update
    # @comment = Comment.find(params[:id])
    @comment = Comment.find(params[:id])
    @blog = @comment.blog
    if @comment.update(comment_params)
      redirect_to blog_path(@blog), notice: "コメントを編集しました！"
    else
      render 'edit'
    end
  end

  def destroy
    # @blog = Blog.find(params[:id])  参考
    @comment = Comment.find(params[:id])
    @comment.destroy
    @blog = @comment.blog
    redirect_to blog_path(@blog), notice: "コメントを削除しました！"
  end

  private
    # ストロングパラメーター
    def comment_params
      params.require(:comment).permit(:blog_id, :content)
    end
end
