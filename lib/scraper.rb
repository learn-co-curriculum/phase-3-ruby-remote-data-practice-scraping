require 'nokogiri'
require 'open-uri'

url = "https://flatironschool.com/"
html = URI.open(url)

doc = Nokogiri::HTML(html)

puts doc.css(".heading-primary").text.strip

courses = doc.css(".dropdown-item")

courses.each do |course|
  puts course.text.strip
end
