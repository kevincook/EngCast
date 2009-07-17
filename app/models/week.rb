class Week < ActiveRecord::Base
  has_many :assignments
  has_many :eningeers, :through => :assignments
  has_many :projects, :through => :assignments
end
