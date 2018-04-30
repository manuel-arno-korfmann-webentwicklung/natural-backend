class User < ApplicationRecord
  has_secure_password
  
  has_many :projects
  has_many :databases
  has_many :tables
  has_many :rows
  has_many :columns
  has_many :row_values
end
