require 'digest'

class User < ActiveRecord::Base
  attr_accessible :username, :pwd, :pwd_confirmation
  attr_accessor :username, :pwd
  
  self.table_name = 'user'
  
  validates :username, :uniqueness => true,
                       :length => { :within => 3..50 }
  validates :pwd, :confirmation => true,
                  :length => { :within => 4..20 },
                  :presence => true,
                  :if => :password_required?
                       
  before_save :encrypt_new_password
                       
  def self.authenticate?(username, password)
    if authenticated?(password)
      return true
    end
  end
  
  def self.authenticated?(password)
    password == 'user123'
  end
  
  protected
  
  def encrypt_new_password
    return if pwd.blank?
    self.password = encrypt(pwd)
  end
  
  def password_required?
    password.blank? || pwd.present?
  end
  
  def encrypt(string)
    Digest::SHA1.hexdigest(string)
  end
end
