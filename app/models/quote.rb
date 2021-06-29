class Quote
  include Mongoid::Document
  field :quote, type: String
  field :author, type: String
  field :author_about, type: String
  field :tags, type: Array

  validates :quote, presence: true
  validates :author, presence: true 
  validates :author_about, presence: true
  validates :tags, presence: true


end
