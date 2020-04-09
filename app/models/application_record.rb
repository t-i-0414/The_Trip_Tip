# frozen_string_literal: true

# default class
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end
