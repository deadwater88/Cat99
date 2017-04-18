class Cat < ActiveRecord::Base
  validates :color, :name, :sex, :description, presence: true
  validate :m_or_f

  has_many :requests,
    foreign_key: :cat_id,
    class_name: :CatRentalRequest,
    dependent: :destroy

  def m_or_f
    unless self.sex == "M" || self.sex == "F"
      errors.add(:sex, "must be either M or F")
    end
  end
end
