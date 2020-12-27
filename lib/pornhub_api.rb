# frozen_string_literal: true

require "uri"
require "net/http"
require "json"

require_relative "pornhub_api/version"

# PornhubApi client namespace
module PornhubApi
  class Error < StandardError; end

  class << self
    BASE_URI = URI("https://www.pornhub.com")

    # Search pornhub videos
    # @param [Hash] options
    # @option options [String] :search Search query
    # @option options [Integer] :page Page number
    # @option options [String] :thumbsize Possible values are small, medium, large, small_hd, medium_hd, large_hd
    # @option options [String] :category The subject
    # @option options [String] :ordering Possible values are featured, newest, mostviewed and rating
    # @option options [Array] :phrase Used as pornstars filter.
    # @option options [Array] :tags The email's body
    # @option options [String] :period Works ith ordering Possible values are weekly, monthly, and alltime
    # @return [Object] response
    #
    # ==== Example Request video search
    # PornhubApi.search # =>
    # {
    #     "videos": [
    #         {
    #             "duration": "11:20",
    #             "views": 2597,
    #             "video_id": "ph5e7cddd1b610e",
    #             "rating": "81.8182",
    #             "ratings": 22,
    #             "title": "Young babe Anna fed cum after anal banging and blowjob",
    #             "url": "https://www.pornhub.com/view_video.php?viewkey=ph5e7cddd1b610e",
    #             "default_thumb": "https://di.phncdn.com/videos/202003/26/296992831/original/(m=eaf8Ggaaaa)",
    #             "thumb": "https://di.phncdn.com/videos/202003/26/296992831/original/(m=eaf8Ggaaaa)13.jpg",
    #             "publish_date": "2020-12-26 12:10:17",
    #             "thumbs": [
    #                 {
    #                     "size": "320x240",
    #                     "width": "320",
    #                     "height": "240",
    #                     "src": "https://di.phncdn.com/videos/202003/26/296992831/original/(mh=_Tyqk2i6XofP-YRe)1.jpg"
    #                 }
    #             ],
    #             "tags": [
    #                 { "tag_name": "hotbabes4k" }
    #             ],
    #             "pornstars": [
    #                { "pornstar_name": "Sheena Ryder" }
    #             ],
    #             "categories": [
    #                 { "category": "babe" },
    #             ],
    #             "segment": "straight"
    #         },
    #     ]
    # }
    def search(**options)
      webmasters_request("search", options)
    end

    # Get pornstars list
    # @return [Object] response
    #
    # ==== Example
    # PornhubApi.stars # =>
    # {
    #     "stars": [
    #         {
    #             "star": {
    #                 "star_name": " Vixxen Goddess"
    #             }
    #         }
    #     ]
    # }
    def stars
      webmasters_request("stars")
    end

    # Get detailed pornstars list
    # @return [Object] response
    #
    # ==== Example
    # PornhubApi.stars_detailed # =>
    # {
    #     "stars": [
    #         {
    #             "star": {
    #                 "star_name": " Melisa Wide",
    #                 "star_thumb": "https://di.phncdn.com/pics/pornstars/default/(m=lciuhScOb_c)female.jpg",
    #                 "star_url": "https://www.pornhub.com/pornstar/videos_overview?pornstar=melisa-wide",
    #                 "gender": "female",
    #                 "videos_count_all": "0"
    #             }
    #         },
    #     ]
    # }
    def stars_detailed
      webmasters_request("stars_detailed")
    end

    # Get video by id
    # @param [Object] id Video id
    # @param [Hash] options
    # @option options [String] thumbsize Possible values are small, medium, large, small_hd, medium_hd, large_hd
    # @return [Object] response
    #
    # ==== Example
    #
    # PornhubApi.video_by_id(id: 'ph5f59beb3df90a') # =>
    # {
    #   "video": {
    #     "duration": "0:04",
    #     "views": 2,
    #     "video_id": "ph5f59beb3df90a",
    #     "rating": 0,
    #     "ratings": 0,
    #     "title": "Dick stroke",
    #     "url": "https://www.pornhub.com/view_video.php?viewkey=ph5f59beb3df90a",
    #     "default_thumb": "https://ei.phncdn.com/videos/202009/10/350564541/original/(m=eaf8Ggaaaa)12.jpg",
    #     "thumb": "https://ei.phncdn.com/videos/202009/10/350564541/original/(m=eaf8Ggaaaa)13.jpg",
    #     "publish_date": "2020-12-26 22:44:47",
    #     "thumbs": [
    #       {
    #         "size": "320x240",
    #         "width": "320",
    #         "height": "240",
    #         "src": "https://ei.phncdn.com/videos/202009/10/350564541/original/(m=eaf8Ggaaaa)15.jpg"
    #       }
    #     ],
    #     "tags": [
    #       {
    #         "tag_name": "big cock"
    #       }
    #     ],
    #     "pornstars": [],
    #     "categories": [
    #       {
    #         "category": "amateur"
    #       }
    #     ],
    #     "segment": "straight"
    #   }
    # }
    def video_by_id(id:, **options)
      webmasters_request("video_by_id", { id: id, **options })
    end

    # Get video activeness
    # @param [Object] id Video id
    # @param [Hash] options
    # @return [Object] response
    # rubocop:disable Naming/PredicateName
    #
    # ==== Example
    # PornhubApi.is_video_active(id: 'ph5f59beb3df90a') # =>
    # {
    #     "active": {
    #         "video_id": "ph5f59beb3df90a",
    #         "is_active": "1"
    #     }
    # }
    def is_video_active(id:, **options)
      webmasters_request("is_video_active", { id: id, **options })
    end
    # rubocop:enable Naming/PredicateName

    # Get all categories
    # @return [Object] response
    # PornhubApi.categories # =>
    # {
    #   "categories": [
    #     {
    #       "id": "139",
    #       "category": "verified-models"
    #     }
    #   ]
    # }
    def categories
      webmasters_request("categories")
    end

    # Get all tags by first char
    # @param [Object] list
    # @return [Object] response
    # PornhubApi.tags(list: 'a') # =>
    # {
    #   "warning": "We had to change the response structure due to high amount of tags. Please adjust your code",
    #   "tagsCount": 283196,
    #   "tags": [
    #     "płąnący",
    #     "płaska",
    #     "płaszcz",
    #     "płaszczyk",
    #     "pławska",
    #     "płock",
    #     "płonę"
    #   ]
    # }
    def tags(list:)
      webmasters_request("tags", { list: list })
    end

    private

    def webmasters_request(path, options = {})
      uri = URI.join(BASE_URI, "webmasters/#{path}")
      uri.query = URI.encode_www_form(options)
      response = Net::HTTP.get_response(uri)
      JSON.parse(response.body, symbolize_names: true)
    rescue Errno::ECONNREFUSED, SocketError => e
      raise Error, e
    end
  end
end
