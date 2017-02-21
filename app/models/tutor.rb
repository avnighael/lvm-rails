class Tutor < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  VALID_PHONE_REGEX = /\A\(?[0-9]{3}\)?(-|\s)?[0-9]{3}-[0-9]{4}\z/
  VALID_ZIP_REGEX   = /\A[0-9]{5}\z/

  has_many :matches
  has_many :students, through: :matches

  has_many :volunteer_jobs
  has_many :coordinators, through: :volunteer_jobs

  validates :email_preferred, presence: true,
                              length: { maximum: 255 },
                              format: { with: VALID_EMAIL_REGEX },
                              uniqueness: { case_sensitive: false }

  validates :email_other, length: { maximum: 255 },
                          format: { with: VALID_EMAIL_REGEX },
                          uniqueness: { case_sensitive: false },
                          allow_blank: true

  validates :cell_phone, allow_blank: true, format: { with: VALID_PHONE_REGEX }
  validates :home_phone, allow_blank: true, format: { with: VALID_PHONE_REGEX }
  validates :other_phone, allow_blank: true, format: { with: VALID_PHONE_REGEX }
  validates :zip, allow_blank: true, format: { with: VALID_ZIP_REGEX }

  validates :first_name, presence: true
  validates :last_name, presence: true

  def name
    [first_name, last_name].join(' ')
  end
end
