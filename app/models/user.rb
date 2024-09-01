class User < ApplicationRecord
    has_secure_password

    validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
    validates :name, presence: true
    validate :password_policy

    private

    def password_policy
        return if password.nil? || password.blank?

        required_types = [/[A-Z]/, /[a-z]/, /\d/, /[^A-Za-z0-9]/]
        matching_types = required_types.count {|type| password.match(type)}
        errors.add(:password, 'must be at least 7 characters and contain at least three of the following: uppercase letter, lowercase letter, digit, special character.') if matching_types < 3 || password.length < 7
    end
end
