# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  username        :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class User < ApplicationRecord
    validates :username, presence: true, uniqueness: true 
    validates :password_digest, :session_token, presence: true 
    validates :password, length: { minimum: 4 }, allow_nil: true
    validates :session_token, uniqueness: true

    before_validation :ensure_session_token

    def ensure_session_token
        self.session_token ||= SecureRandom::urlsafe_base64
    end

    def password=(new_pw)
        self.password_digest = BCrypt::Password.create(new_pw)
        @password = new_pw
    end

    def is_password?(new_pw)
        pw_object = BCrypt::Password.new(self.password_digest)
        pw_object.is_password?(new_pw)
    end

    def self.find_my_creds(username, password)
        user = User.find_by(username: :username)

        if user && user.is_password?(password)
            return user
        else
            return nil
        end
    end

    def reset_session_token!
        self.generate_unique_session_token
        self.save
        self.session_token
    end
    
    private
    
    attr_reader :password

    def generate_unique_session_token
        self.session_token = SecureRandom.urlsafe_base64
    end

  

end
