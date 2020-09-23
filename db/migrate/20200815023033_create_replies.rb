class CreateReplies < ActiveRecord::Migration[5.2]
  def change
        create_table :replies do |t|
    t.string :name
    t.string :body
    t.integer :good
    t.references :contribution
    t.timestamps null: false
    end
  end
end
