class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.string :title
      t.string :location
      t.string :date
      t.string :description
    end
  end
end