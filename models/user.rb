class User < ActiveRecord::Base
  has_many :projects
  has_many :work_sessions, through: :projects
end
