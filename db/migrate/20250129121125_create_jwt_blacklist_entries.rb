class CreateJwtBlacklistEntries < ActiveRecord::Migration[7.1]
  def change
    create_table :jwt_blacklist_entries do |t|
      t.string :jti
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :jwt_blacklist_entries, :jti
  end
end
