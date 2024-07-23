require 'nokogiri'
require 'open-uri'
require 'uri'

html = URI.open("http://flatironschool.com/")
doc = Nokogiri::HTML(html)

doc.css("section.column-highlights:nth-child(2) > div:nth-child(1) > div:nth-child(2) > div:nth-child(1) > h3:nth-child(2)")


