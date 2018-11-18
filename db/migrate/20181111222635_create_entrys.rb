class CreateEntrys < ActiveRecord::Migration
  def change
    create_table :entrys do |t|
      t.string :title
      t.string :location
      t.string :date
      t.string :description
      t.integer :log_id
      t.integer :user_id
    end
  end
end