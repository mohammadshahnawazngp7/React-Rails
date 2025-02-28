class CreateReferrals < ActiveRecord::Migration[7.1]
  def change
    create_table :referrals do |t|
      t.references :user, null: false, foreign_key: true
      t.string :email
      t.boolean :invited

      t.timestamps
    end
  end
end
