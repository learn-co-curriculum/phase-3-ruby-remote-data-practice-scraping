require 'nokogiri'
require 'open-uri'

doc = Nokogiri::HTML(URI.open("https://flatironschool.com/"))
p doc.css(".cli-modal-footer")[0].attributes

