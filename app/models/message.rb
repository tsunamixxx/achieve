class Message < ActiveRecord::Base

  # DIVE02_Rails基礎2のバリデーションの命令をそのままコピペしたためbodyが重複し、コメントのエラー表示がおかしくなっていた。
  # validates :body, presence: true

  belongs_to :conversation
  belongs_to :user

  validates_presence_of :body, :conversation_id, :user_id
  def message_time
    created_at.strftime("%m/%d/%y at %l:%M %p")
  end
end
