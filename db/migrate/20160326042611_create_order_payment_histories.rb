class CreateOrderPaymentHistories < ActiveRecord::Migration
  def change
    create_table :order_payment_histories do |t|
      t.references :order, index: true, foreign_key: true
      t.integer :status, null:false
      t.datetime :status_date, null:false
      t.timestamps null: false
    end
  end
end
