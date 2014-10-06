class Workshop < ActiveRecord::Base
  
  validates :user, presence:true
  validates :description, presence:true, length: {maximum:200}
  validates :start_date, presence:true
  validates :end_date, presence:true
  validates :vacancies_number, presence:true, numericality: {only_integer:true}
  validates :value, presence:true, numericality:true

  belongs_to :user

end
