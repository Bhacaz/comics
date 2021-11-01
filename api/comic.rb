# frozen_string_literal: true

require 'json'
require 'cgi'
require 'uri'
require 'net/http'

TITLE_REGEX = %r{<h2 class="listmanga-header">\s+(.+?)\s+</h2>}.freeze
SUMMARY_REGEX = %r{Summary</strong></h5>\s+<p>(.+?)</p>}.freeze
TYPE_REGEX = %r{Type</dt>\s+<dd>\s+(.+?)\s+</dd>}.freeze
STATUS_REGEX = %r{Status</dt>\n|.+<span class="label.+">(.+?)</span>}.freeze
DATE_OF_RELEASE_REGEX = %r{Date of release</dt>\s+<dd>(.+?)</dd>}.freeze
RATING_REGEX = %r{Average (.+?)/5}.freeze
CHAPTERS_INFOS = %r{<h5 class="chapter-title-rtl">\s+<a href="(.+/(\d+))">(.+?)</a>}.freeze # URL, number, name
COVER_URL_REGEX = %r{'(//.+/cover/.+?)'}.freeze

class BuildComicData
  def self.single_match(content, regex)
    content.match(regex)&.captures&.first
  end

  def self.multi_match(content, regex)
    content.scan(regex)
  end
end

Handler = proc do |req, res|
  params = CGI.parse(req.query_string).transform_values(&:first)

  base_url = 'https://readcomicsonline.ru/comic/'

  uri = URI("#{base_url}#{params['id']}")
  uri.query = URI.encode_www_form(params)

  response = Net::HTTP.get_response(uri)

  comic_page_concent = response.body.force_encoding(Encoding::UTF_8)

  comic_data_builder = {
    title: TITLE_REGEX,
    summary: SUMMARY_REGEX,
    cover: COVER_URL_REGEX,
    type: TYPE_REGEX,
    status: STATUS_REGEX,
    date_of_release: DATE_OF_RELEASE_REGEX,
    rating: RATING_REGEX
  }

  data = comic_data_builder.transform_values do |regex|
    BuildComicData.single_match(comic_page_concent, regex)
  end
  data[:cover] = "https:#{data[:cover]}"

  data[:chapters] = BuildComicData.multi_match(comic_page_concent, CHAPTERS_INFOS).map do |url, number, name|
    {
      name: name,
      number: number,
      url: url
    }
  end
  data[:chapters].sort_by! { |chapter| chapter[:number].to_i }

  res.status = 200
  res['Content-Type'] = 'text/text; charset=utf-8'
  res.body = data.to_json
end
