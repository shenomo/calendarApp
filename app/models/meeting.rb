class Meeting < ActiveRecord::Base

	acts_as_schedulable :schedule
	belongs_to :user
end
