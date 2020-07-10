class User < ApplicationRecord
    # Necessary to authenticate
    has_secure_password

    # Basic password validation, configure to your liking
    validates_length_of :password, maximum: 72, minimum: 8, allow_nil: true, allow_blank: false
    validates_confirmation_of :password, allow_nil: true, allow_blank: false

    before_validation {
        (self.email = self.email.to_s.downcase)
    }

    # Make sure email and names are present, email should be unique
    validates_presence_of :email
    validates_uniqueness_of :email
    validates_presence_of :first_name
    validates_presence_of :last_name

    def can_modify_user?(user_id)
        role == 'admin' || id.to_s == user_id.to_s
    end

    def is_admin?
        role == 'admin'
    end
    
end
