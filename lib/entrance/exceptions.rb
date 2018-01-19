require 'grape'

module Entrance
  module Exceptions
    ValidationErrors = Class.new(Grape::Exceptions::ValidationErrors)
  end
end