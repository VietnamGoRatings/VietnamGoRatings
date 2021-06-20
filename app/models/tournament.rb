# frozen_string_literal: true

# == Schema Information
#
# Table name: tournaments
#
#  id         :integer          not null, primary key
#  end_date   :integer
#  name       :string           not null
#  start_date :integer
#
class Tournament < ApplicationRecord
  has_many :matches
end
