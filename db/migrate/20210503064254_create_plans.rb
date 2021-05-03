class CreatePlans < ActiveRecord::Migration[6.1]
  def change
    create_table :plans do |t|
      t.string :title
      t.string :price_id
      t.boolean :free,default: false
      t.json :benefits,default:{}
      t.float :price
      t.string :description

      t.timestamps
    end
  end
end
