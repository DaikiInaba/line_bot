class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string     :name
      t.text       :mid, null: false
      t.integer    :stage
      t.boolean    :questioner, null: false, default: false
      t.references :region
      t.references :tmp_region
      t.timestamps null: false
    end
  end
end
