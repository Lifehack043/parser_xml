class Lot < ActiveRecord::Base
    belongs_to :purchase
    has_many :lot_items
    accepts_nested_attributes_for :lot_items
end