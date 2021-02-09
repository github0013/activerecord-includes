class CreateCs < ActiveRecord::Migration[6.1]
  def change
    create_table :cs do |t|
      t.references :b, null: false
      t.references :d, null: true
      t.string :name, null: false
      t.string :type_name, null: false
      t.timestamps
    end
  end
end
