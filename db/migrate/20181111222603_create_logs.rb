class CreateLogs < ActiveRecord::Migration
  def change
   create_table :logs do |t|
      t.string :title
      t.integer :user_id
      t.integer :points
    end
  end
end