class Article < ApplicationRecord
    belongs_to :user
    validates :user, presence: true
    validates :title, :content, presence: true
    has_many :comments, dependent: :destroy
end
