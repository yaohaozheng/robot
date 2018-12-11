class Message < ActiveRecord::Base
  belongs_to :user
  belongs_to :chat

  has_attached_file :img, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :img, content_type: /\Aimage\/.*\z/

  sync :all
  sync_scope :by_chat, ->(chat) { where(chat_id: chat.id) }
end
