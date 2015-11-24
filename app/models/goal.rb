class Goal < ActiveRecord::Base
  validates :title, :user_id, :private, presence: true

  belongs_to :user
end
