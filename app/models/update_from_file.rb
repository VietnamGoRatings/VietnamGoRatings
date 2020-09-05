# frozen_string_literal: true

# == Schema Information
#
# Table name: update_from_files
#
#  id         :integer          not null, primary key
#  data       :string           not null
#  type       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class UpdateFromFile < ApplicationRecord
  after_create_commit :process_file
  has_one_attached :file
end
