class CreateRoomMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :room_messages do |t|
      t.string :msg
      t.references :room, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
