class User < ApplicationRecord
  has_many :aways
  has_many :sent_messages, class_name: "Message", foreign_key: "sender_id"
  has_many :received_messages, class_name: "Message", foreign_key: "receiver_id"

  has_secure_password
  validates :username, presence: true
  validates :username, uniqueness: true


end
