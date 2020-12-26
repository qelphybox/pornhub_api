# frozen_string_literal: true

require "uri"
require "net/http"
require "json"

require_relative "pornhub_api/version"

# PornhubApi client namespace
module PornhubApi
  class Error < StandardError; end

  class << self
    BASE_URI = URI("https://rt.pornhub.com")

    # Search pornhub videos
    # @param [Hash] options
    # @option options [String] :search Search query
    # @option options [Integer] :page Page number
    # @option options [String] :thumbsize Possible values are small,medium,large,small_hd,medium_hd,large_hd
    # @option options [String] :category The subject
    # @option options [String] :ordering Possible values are featured, newest, mostviewed and rating
    # @option options [Array] :phrase Used as pornstars filter.
    # @option options [Array] :tags The email's body
    # @option options [String] :period Only works with ordering parameter.
    #                                  Possible values are weekly, monthly, and alltime
    # @return [Object] response
    def search(**options)
      webmasters_request("search", options)
    end

    # Get pornstars list
    # @return [Object] response
    def stars
      webmasters_request("stars")
    end

    # Get detailed pornstars list
    # @return [Object] response
    def stars_detailed
      webmasters_request("stars_detailed")
    end

    # Get video by id
    # @param [Object] id Video id
    # @param [Hash] options
    # @option options []
    # @return [Object] response
    def video_by_id(id:, **options)
      webmasters_request("video_by_id", { id: id, **options })
    end

    # @param [Object] id Video id
    # @param [Hash] options
    # @return [Object] response
    # rubocop:disable Naming/PredicateName
    def is_video_active(id:, **options)
      webmasters_request("is_video_active", { id: id, **options })
    end
    # rubocop:enable Naming/PredicateName

    # @return [Object] response
    def categories
      webmasters_request("categories")
    end

    # @param [Object] list
    # @return [Object] response
    def tags(list:)
      webmasters_request("tags", { list: list })
    end

    private

    def webmasters_request(path, options = {})
      uri = URI.join(BASE_URI, "webmasters/#{path}")
      uri.query = URI.encode_www_form(options)
      response = Net::HTTP.get_response(uri)
      JSON.parse(response.body, symbolize_names: true)
    end
  end
end
