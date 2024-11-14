class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books do |t|
      t.string :book_name
      t.string :description
      t.integer :price
      t.string :auther
      t.integer :rating

      t.timestamps
    end
  end
end
