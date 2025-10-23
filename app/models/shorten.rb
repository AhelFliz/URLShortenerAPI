class Shorten < ApplicationRecord
  validates :url, presence: true
  validates :short_code, uniqueness: true

  before_create :generate_short_url

  private

  def generate_short_url
    self.short_code = loop do
      random = SecureRandom.hex(6)
      break random unless Shorten.exists?(short_code: random)
    end
  end
end
