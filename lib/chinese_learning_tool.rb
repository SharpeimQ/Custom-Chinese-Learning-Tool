# frozen_string_literal: true

require 'google/apis/docs_v1'
require 'googleauth'
require 'googleauth/stores/file_token_store'

# class containing methods to manipulate learning data
class ChineseLearningTool
  def initialize(file_id, credentials_path)
    @file_id = file_id
    @credentials_path = credentials_path
  end

  def count_unique_chars
    authenticate
    content = extract_document_content
    chinese_chars = extract_chinese_char(content)
    count = chinese_chars.uniq.size
    puts "You have learned #{count} unique Chinese characters!"
  end

  def shuffle_unique_chars
    authenticate
    content = extract_document_content
    shuffled_unique_chinese_chars = extract_chinese_char(content).uniq.shuffle
    shuffled_unique_chinese_chars.each { |char| print "#{char} " }
    puts
  end

  # authentication methods are kept private
  private

  def authenticate
    token_store = Google::Auth::Stores::FileTokenStore.new(file: @credentials_path)
    authorizer = Google::Auth::ServiceAccountCredentials.make_creds(
      json_key_io: File.open(@credentials_path),
      scope: Google::Apis::DocsV1::AUTH_DOCUMENTS_READONLY,
      token_store: token_store
    )

    # Initialize the Google Docs API client
    @service = Google::Apis::DocsV1::DocsService.new
    @service.authorization = authorizer
  end

  def extract_document_content
    @service.get_document(@file_id).body.content
  end

  def extract_chinese_char(content)
    content.each_with_object([]) do |element, result|
      next unless element.paragraph&.elements

      element.paragraph.elements.each do |paragraph_element|
        next unless paragraph_element.text_run

        result << paragraph_element.text_run.content.scan(/[\p{Han}&&[^0-9]]/u)
      end
    end.flatten
  end
end
