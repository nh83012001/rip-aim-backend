class Message < ApplicationRecord
  belongs_to :sender, class_name: "User", primary_key: "sender_id"
  belongs_to :recipient, class_name: "User", primary_key: "reciever_id"
end
