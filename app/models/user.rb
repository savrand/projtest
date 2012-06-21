class User < ActiveRecord::Base
  attr_accessible :email, :password,:lastname, :login, :name, :password_confirmation, :avatar ,:byrthday,:phone_number
  
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" },
                             :default_url => '/images/1.jpg'

  attr_accessor :password
  before_save :encrypt_password
  
  validates_confirmation_of :password

  validates_presence_of :password, :on => :create

  validates :byrthday, :presence => true

  validates :phone_number, :presence => true, 
                    :length => {:minimum => 10, :maximum => 10}

  validates :email, :presence => true, 
                    :length => {:minimum => 3, :maximum => 254},
                    :uniqueness => true,
                    :format => {:with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i}
  
  validates :login, :presence => true,
                    :length => { :maximum => 50 },
                    :uniqueness =>true
  
  validates :password,:length => { :maximum => 16,:minimum => 6 }, :on => :create

  validates :name, :presence => true,
                   :length => { :maximum => 50 }

  validates :lastname, :presence => true,
                       :length => { :maximum => 50 }

  
  def self.authenticate(login, password)
    user = find_by_login(login)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end
  
  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end
end


