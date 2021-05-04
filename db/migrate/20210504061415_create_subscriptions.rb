class CreateSubscriptions < ActiveRecord::Migration[6.1]
  def change
    create_table :subscriptions do |t|
      t.date :start_date
      t.date :end_date
      t.boolean :active, default: true
      t.belongs_to :plan
      t.belongs_to :user

      t.timestamps
    end
  end
end
