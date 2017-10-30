class CommentsController < ApplicationController
  # コメントを保存、投稿するためのアクションです。
  def create
    # Blogをパラメータの値から探し出し,Blogに紐づくcommentsとしてbuildします。
    @comment = current_user.comments.build(comment_params)
    @blog = @comment.blog
    # クライアント要求に応じてフォーマットを変更
    respond_to do |format|
      if @comment.save
        format.html {redirect_to blog_path(@blog), notice: 'コメントを投稿しました！'}
        # JS形式でレスポンスを返します。
        format.js { render :index }
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
