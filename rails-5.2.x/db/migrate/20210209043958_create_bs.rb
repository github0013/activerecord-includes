class CreateBs < ActiveRecord::Migration[5.2]
  def change
    create_table :bs do |t|
      t.references :a, null: false
      t.string :name, null: false
      t.timestamps
    end
  end
end
