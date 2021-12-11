class A < ApplicationRecord
  has_many :bs
  has_many :cs, through: :bs, source: "cs"
  has_many :c_type_xs, -> { type_x }, through: :bs, source: "cs"
  has_many :ds, -> { distinct }, through: :cs

  has_many :c_of_by, -> { where(bs: {name: 'y'}) } , through: :bs, source: "cs"
end
