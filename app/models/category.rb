class Category < ApplicationRecord
  before_validation :generate_slug, on: :create

  validates :title, presence: true
  validates :description, presence: true, length: { minimum: 10 }
  validates :slug, presence: true, uniqueness: true

  def to_param
    slug
  end

  private

  def generate_slug
    self.slug = title.present? ? title.parameterize : SecureRandom.hex(4)
  end
end
