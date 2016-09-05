class AddColumnParticipatingRaffleBasketToUsers < ActiveRecord::Migration
  def change
    add_column :users, :participating_raffle_basket, :boolean, null:false, default:false
  end
end
