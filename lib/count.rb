# frozen_string_literal: true

require_relative 'chinese_learning_tool'

file_id = '1Z5OrYC2HS4boqnDMF0y_qUwa2Dkq3RIm8aEy47v-yMM'
credentials_path = '/home/sharpeim/Desktop/Developer/uniq-chinese-char-count-2442e44427dd.json'
chinese = ChineseLearningTool.new(file_id, credentials_path)
chinese.count_unique_chars
