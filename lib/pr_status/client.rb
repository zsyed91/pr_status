require 'octokit'
module PrStatus
  # Client class for Octokit
  #  Holds an internal reference to Octokit::Client
  #  and other related methods for interacting with octokit's api wrapper
  class Client
    attr_accessor :user
    def initialize(credentials)
      @octokit = Octokit::Client.new(credentials)
      # Cache the user info so we don't have to make another request
      @user = @octokit.user
    end

    def pull_requests(filters = {})
      filters = default_filters.merge(filters)
      @octokit.search_issues(build_query(filters))[:total_count]
    end

    def repos
      @repos ||= @octokit.repos
    end

    private

    def build_query(filters)
      ["author:#{@user[:login]}",
       'type:pr',
       "created:>=#{filter_date(filters)}"].join(' ')
    end

    def filter_date(filters)
      time = Time.now
      case filters[:range]
      when 'monthly'
        if time.month < 10
          "#{time.year}-0#{time.month}-01"
        else
          "#{time.year}-#{time.month}-01"
        end
      end
    end

    def default_filters
      { range: 'monthly' }
    end
  end
end
