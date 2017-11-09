class Comment < ActiveRecord::Base
  # CommentモデルがCommentモデル内にあるuser_idを外部キーとしてUserモデルと関連づいている
  belongs_to :user
  # CommentモデルがCommentモデル内にあるblog_idを外部キーとしてBlogモデルと関連づいている
  belongs_to :blog

  has_many :notifications, dependent: :destroy
end
