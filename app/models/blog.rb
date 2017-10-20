class Blog < ActiveRecord::Base
    validates :title, presence: true
    belongs_to :user #dependentはいらないの？ユーザーを消したときに紐付いたブログやコメントは消さないの？

    # CommentモデルのAssociationを設定
    has_many :comments, dependent: :destroy
end
