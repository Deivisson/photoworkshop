class City < ActiveRecord::Base
  belongs_to :state
  has_many :user_profiles

  default_scope -> {order("name asc")}
  scope :state, -> (state) {select("id,name").where(state_id: state)}

end
