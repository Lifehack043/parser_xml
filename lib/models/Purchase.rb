class Purchase < ActiveRecord::Base
    belongs_to :customer
    has_many :lots
    accepts_nested_attributes_for :customer, :lots
end