class C < ApplicationRecord
  belongs_to :b
  belongs_to :d, required: false
  scope :type_x, -> { where(type_name: :x) }
  scope :type_not_x, -> { where.not(type_name: :x) }
end
