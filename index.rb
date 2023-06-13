# frozen_string_literal: true

require 'google_drive'

def count_unique_chinese_characters_from_google_docs(file_id, credentials_path)
  session = GoogleDrive::Session.from_service_account_key(credentials_path)
  doc = session.file_by_id(file_id)
  content = doc.export_as_string('text/plain')

  chinese_characters = content.scan(/[\p{Han}&&[^0-9]]/u)
  unique_characters = chinese_characters.to_set

  unique_characters.size
end

file_id = '1Z5OrYC2HS4boqnDMF0y_qUwa2Dkq3RIm8aEy47v-yMM'
credentials_path = '/home/sharpeim/Desktop/Developer/uniq-chinese-char-count-2442e44427dd.json'
unique_count = count_unique_chinese_characters_from_google_docs(file_id, credentials_path)
puts "You have learned #{unique_count} unique Chinese characters!"
