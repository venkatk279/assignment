class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :tweets
  has_many :active_relations, class_name: "Relation", foreign_key: "follower_id", dependent: :destroy
  has_many :passive_relations, class_name: "Relation", foreign_key: "followed_id", dependent: :destroy
  has_many :following, through: :active_relations, source: :followed
  has_many :followers, through: :passive_relations, source: :follower

  def follow(user)
    active_relations.create(followed_id: user.id)
  end

  def unfollow(user)
    active_relations.find_by(followed_id: user.id).destroy
  end

  def following?(user)
    followers.include?(user)
  end

  def self.all_except(user)
    where.not(id: user)
  end

end
