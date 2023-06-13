# frozen_string_literal: true

require 'open-uri'
require 'nokogiri'
require 'set'

def count_unique_characters_from_website(url)
  content = open(url).read

  chinese_characters = content.scan(/[\p{Han}&&[^0-9]]/u)
  unique_characters = chinese_characters.to_set

  unique_characters.size
end

website_url = 'https://docs.google.com/document/d/1Z5OrYC2HS4boqnDMF0y_qUwa2Dkq3RIm8aEy47v-yMM/edit'
unique_count = count_unique_characters_from_website(website_url)
puts unique_count
