class Blog < ActiveRecord::Base
    validates :title, presence: true
    # BlogモデルがBlogモデル内にあるuser_idを外部キーとしてUserモデルと関連づいている
    belongs_to :user #dependentはいらないの？ユーザーを消したときに紐付いたブログやコメントは消さないの？

    # CommentモデルのAssociationを設定
    # BlogモデルがCommentモデル内にあるblog_idを外部キーとしてCommentモデルと関連づいている
    has_many :comments, dependent: :destroy
end
