require "open-uri"
require "nokogiri"

day = 6
url = "https://adventofcode.com/2024/day/#{day}/input"

session_cookie = "53616c7465645f5f787d5ef6c4e659c927d27b700b70ccdc3ab85442c315e30654269a28003dff8e65037535505e341988f731b128846822fcbdb054cc7dec92"

begin
  html_file = URI.open(
    url,
    "Cookie" => "session=#{session_cookie}",
    "User-Agent" => "Mozilla/5.0 (compatible; Ruby script; AdventOfCode)"
  ).read

  # Parse the HTML document
  html_doc = Nokogiri::HTML.parse(html_file)
  content = html_doc.text
  p content
end
