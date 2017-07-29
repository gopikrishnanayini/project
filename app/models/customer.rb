class Customer < ActiveRecord::Base
	validates :cust_id, presence: true
	validates :name, presence: true
	validates :description, presence: true
end
