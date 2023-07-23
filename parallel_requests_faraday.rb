require 'faraday'
require 'faraday/tyhoeus'


conn = Faraday.new('http://httpbingo.org') do |faraday|
  faraday.adapter :typhoeus
end

now = Time.now

urls = ['/delay/3', '/delay/3']
results = []

res = conn.in_parallel do
  perform_request(conn, urls, results)
end

def perform_request(conn, urls, results)
  for url in urls
    results << conn.get(url).body
  end
end

p results

# This should take about 3 seconds, not 6.
puts "Time taken: #{Time.now - now}"