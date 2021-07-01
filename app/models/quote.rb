class Quote
  include Mongoid::Document
  field :quote, type: String
  field :author, type: String
  field :author_about, type: String
  field :tags, type: Array

  validates :quote, presence: true, uniqueness: true
  validates :author, presence: true
  validates :author_about, presence: true
  validates :tags, presence: true

  # scope :tag, ->(tag) { where(tags: tag).cache }
  # scope :term, ->(term) { text_search(term).cache }

  # index for text
  index({quote: "text"}, {unique: true, name: "quote_index"})
end
