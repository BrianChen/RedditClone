class Post < ActiveRecord::Base
  validates :title, :sub_id, presence: true
  belongs_to :sub
  belongs_to :author,
    class_name: :User,
    primary_key: :id,
    foreign_key: :author_id

end
