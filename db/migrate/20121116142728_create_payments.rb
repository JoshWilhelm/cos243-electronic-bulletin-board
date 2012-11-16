class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.string :Detail
      t.integer :user_id
      t.decimal :amount
      t.integer :payable_id
      t.string :payable_type

      t.timestamps
    end
  end
end
