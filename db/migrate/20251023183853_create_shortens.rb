class CreateShortens < ActiveRecord::Migration[8.0]
  def change
    create_table :shortens do |t|
      t.string :url
      t.string :short_code
      t.integer :access_count, default: 0

      t.timestamps
    end
  end
end
