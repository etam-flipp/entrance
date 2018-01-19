require 'grape'

module Rentrance
  module Exceptions
    ValidationErrors = Class.new(Grape::Exceptions::ValidationErrors)
  end
end