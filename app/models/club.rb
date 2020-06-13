# frozen_string_literal: true

# == Schema Information
#
# Table name: clubs
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Club < ApplicationRecord
  has_many :player
end
