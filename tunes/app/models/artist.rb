class Artist < ActiveRecord::Base
  has_many :albums, dependent: :destroy
  has_many :songs, through: :albums
end
