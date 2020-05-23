class ScheduleDate < ApplicationRecord
  validates :date, uniqueness: true
  validates_date :date, :on_or_after => lambda { DateTime.now }
end
