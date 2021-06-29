module Api
  module V1
    class QuotesController < ApiController
      # skip_before_action :authenticate_user
      
      def search_tag
        tag = params[:search_tag]
        @quotes = Quote.where(tags: tag).cache.to_a
        
        if @quotes.empty?
          @quotes = query_tags(tag)
        end

        render :quotes,status: :ok and return 
      end

      private 
      def query_tags(tag)
        @results = WebCrawlerService.new(tag).results   
        return if @results.empty?
        Quote.create!(@results)
        return @results
      end
    end
  end
end
