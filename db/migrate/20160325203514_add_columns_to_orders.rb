class AddColumnsToOrders < ActiveRecord::Migration
  def change
  	add_column :orders, :description, :string, null:false, default:''
    add_column :orders, :origin, :integer, null:false, default:1
    add_column :orders, :workshop_plan_id, :integer, index:true, foreign_key:true
    add_column :orders, :payment_type, :integer
    add_column :orders, :payment_code, :integer
    add_column :orders, :gross_amount, :decimal,precision: 5, scale: 2, null:false,default:0
    add_column :orders, :discount_amount, :decimal,precision: 5, scale: 2, null:false,default:0
    add_column :orders, :net_amount, :decimal,precision: 5, scale: 2, null:false,default:0
    add_column :orders, :extra_amount, :decimal,precision: 5, scale: 2, null:false,default:0
    add_column :orders, :installment_count, :integer, null:false, default:1
    add_column :orders, :last_status_update_at, :datetime
  end
end


