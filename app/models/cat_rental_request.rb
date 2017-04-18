class CatRentalRequest < ActiveRecord::Base
  validates :cat_id, :start_date, :end_date, :status, presence: true
  validates :status, inclusion: { in: %w(PENDING APPROVED DENIED)}
  validate :does_not_overlap_approved_requests

  belongs_to :cat

  def overlapping_requests
    self.cat.requests.where("cat_rental_requests.id != #{self.id}")
    .where(<<-SQL)
      '#{start_date.to_s}' BETWEEN cat_rental_requests.start_date AND cat_rental_requests.end_date
      OR '#{end_date.to_s}' BETWEEN cat_rental_requests.start_date AND cat_rental_requests.end_date

    SQL
  end

  def overlapping_approved_requests
    overlapping_requests.where("cat_rental_requests.status = 'APPROVED'")
  end

  def does_not_overlap_approved_requests
    if overlapping_approved_requests.exists?
      errors.add(:base, "Can't overlap approved request")
    end
  end

  def approve!
    self.status = "APPROVED"
    self.save
    # overlapping_requests.each do |request|
    #   request.deny!
    # end
    overlapping_requests.update_all(status: "DENIED")
  end

  def deny!
    self.status = "DENIED"
    self.save
  end

end
