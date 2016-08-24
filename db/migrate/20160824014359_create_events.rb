class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.timestamps :started_at
      t.timestamps :expired_at
      t.text       :name
      t.string     :prefecture
      t.string     :city
      t.text       :event_url

      t.timestamps null: false
    end
  end
end
