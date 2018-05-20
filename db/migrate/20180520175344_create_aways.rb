class CreateAways < ActiveRecord::Migration[5.1]
  def change
    create_table :aways do |t|
      t.integer :user_id
      t.text :message
      t.timestamps
    end
  end
end
