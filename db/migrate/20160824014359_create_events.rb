class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.date       :started_at
      t.date       :expired_at
      t.text       :name
      t.string     :prefecture
      t.string     :city
      t.text       :event_url

      t.timestamps null: false
    end
  end
end
