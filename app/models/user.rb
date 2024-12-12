class User
  include RedisAdapter
  include ActiveModel::API
  include ActiveModel::Validations
  include ActiveModel::SecurePassword
  include ActiveModel::Serializers::JSON

  has_secure_password

  attr_accessor :username, :password_digest

  def attributes
    { "username" => nil, "password_digest" => nil }
  end

  validates :username, presence: true, format: { with: /\A[a-zA-Z0-9_]+\z/ }
  validates :password, presence: true, length: { minimum: 8 },
            format: {
              with: /\A(?=.*[A-Z])(?=.*[!@#$&*])(?=.*[0-9])(?=.*[a-z]).{8,}\z/,
              message: "must include uppercase, lowercase, number and special character"
            }


  private
end
