class Sub < ActiveRecord::Base

  validates :title, :moderator_id, presence: true
  validates :moderator_id, uniqueness: {scope: :title}

  belongs_to :moderator,
    class_name: :User,
    primary_key: :id,
    foreign_key: :moderator_id

end
