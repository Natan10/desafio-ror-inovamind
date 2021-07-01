module Api
  module V1
    class QuotesController < ApiController
      def search_tag
        tag = params[:search_tag]
        # @quotes = Quote.tag(tag).to_a
        @quotes = Quote.where(tags: tag).to_a.cache
        if @quotes.empty?
          @quotes = query_tags(tag)
        end
        render :quotes
      end

      def authors
        @authors = Quote.pluck(:author, :author_about).uniq
        render :authors
      end

      def terms
        
        # @quotes = Quote.term(params[:term])
        @quotes = Quote.text_search(term).cache
        render :quotes
      end

      private

      def query_tags(tag)
        @results = WebCrawlerService.new(tag).results
        return if @results.empty?
        Quote.create!(@results)
        @results
      end
    end
  end
end
