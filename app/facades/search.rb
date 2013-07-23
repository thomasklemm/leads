class Search
  attr_accessor :query

  def initialize(query, page=1)
    @query = query
    @page = page
  end

  # Page 1 is first and lowest page number
  def page
    page = @page.to_i
    page > 1 ? page : 1
  end

  def previous_page
    "#{ query_url }&page=#{ page - 1 }" if page > 1
  end

  def next_page
    "#{ query_url }&page=#{ page + 1 }"
  end

  def results
    @results ||= begin
      return unless query.present?
      users = Twitter.user_search(query, count: 20, page: page)
      users.map { |user| LeadDecorator.new(user) }
    end
  end

  private

  def query_url
    "/leads/search?query=#{ URI.escape(query) }"
  end
end
