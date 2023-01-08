class User < ApplicationRecord
  include GenerateRandomNumber

  PHONE_REGEX = /^(009665|9665|\+9665|05)(5|0|3|6|4|9|1)([0-9]{7})$/i
  CONFIRMATION_TOKEN_LENGTH = 6
  NULLIFY_TOKEN_WAITING_TIME = 15 # in minutes

  has_secure_password
  has_one_attached :avatar

  after_create :set_confirmation_token, :insert_nullify_token_job


  validates_uniqueness_of :mobile, conditions: -> { where.not(confirmed_at: nil) }
  validates :mobile, presence: true

  validates_format_of :mobile, with: PHONE_REGEX, multiline: true
  validates_uniqueness_of :confirmation_token, allow_nil: true
  validates_uniqueness_of :reset_password_otp, allow_nil: true



  def confirmed?
    !!confirmed_at
  end

  def confirm!
    if update(confirmed_at: DateTime.now)
      nullify_confirmation_token!
    end
  end

  def set_confirmation_token
    update(confirmation_token: create_uniq_random_number(CONFIRMATION_TOKEN_LENGTH, :confirmation_token))
  end

  def set_reset_password_otp
    update(reset_password_otp: create_uniq_random_number(CONFIRMATION_TOKEN_LENGTH, :reset_password_otp))
    insert_nullify_reset_otp_job
  end

  def create_uniq_random_number(number_of_digits=6, token_type)
    code = generate_random_number(number_of_digits)
    loop do
      break unless self.class.exists?( token_type => code)
      code = generate_random_number(number_of_digits)
    end
    code
  end

  def nullify_confirmation_token!
    update(confirmation_token: nil)
  end

  def nullify_reset_password_otp!
    update(reset_password_otp: nil)
  end


  def insert_nullify_token_job
    NullifyConfirmationTokenJob.set(wait: NULLIFY_TOKEN_WAITING_TIME.minute).perform_later(self.id)
  end

  def insert_nullify_reset_otp_job
    NullifyResetPasswordOtpJob.set(wait: NULLIFY_TOKEN_WAITING_TIME.minute).perform_later(self.id)
  end

  def admin?
    self.type == "Admin"
  end
end
