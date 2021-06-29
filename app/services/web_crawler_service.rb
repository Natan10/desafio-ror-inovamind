require "nokogiri"
require "open-uri"

class WebCrawlerService
  attr_reader :tag

  def initialize(tag)
    @tag = tag
  end

  def results
    doc = Nokogiri::HTML(URI.open(path))
    find_info(doc)
  end

  private

  def find_info(doc)
    results = []
    doc.search("div .quote").each do |obj|
      results << process_obj(obj)
    end
    results
  end

  def process_obj(obj)
    {
      text: obj.search("span.text").text,
      author: obj.at("span small.author").text,
      author_about: PATH + obj.at("span a[href]")["href"],
      tags: obj.at_css("div.tags meta.keywords")["content"].split(",")
    }
  end

  def path(tag)
    "http://quotes.toscrape.com/tag/#{@tag}/page/1/"
  end
end
