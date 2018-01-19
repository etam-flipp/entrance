require 'grape/dsl/settings'
require 'grape/dsl/logger'
require 'grape/dsl/desc'
require 'grape/dsl/configuration'
require 'grape/dsl/validations'
require 'rails'
require 'rails/all'
require 'forwardable'

require_relative 'exceptions'

class Entrance::Base
  include Grape::DSL::Validations
  include Grape::DSL::Settings
  include Grape::DSL::InsideRoute::PostBeforeFilter

  extend Forwardable
  CONTROLLER_DELEGATIONS = [
    :render,
    :render_partial,
    :redirect_to,
    :request
  ]
  def_delegators :controller, *CONTROLLER_DELEGATIONS


  attr_accessor :controller
  def initialize(controller:)
    @controller = controller

    _validate_controller!
    _configure_params!
    _validate_params!
  end

  def perform
    raise NotImplementedError
  end

  def params
    @_params ||= declared(controller.params.to_unsafe_hash).deep_symbolize_keys
  end

protected

  def method_missing(meth)
    return params[meth] if _declared_param_provided?(meth)
    super
  end

  def respond_to_missing?(meth, *args)
    _declared_param_provided?(meth) || super
  end

  def _validate_controller!
    raise ArgumentError, "A Rails ActionController context must be provided!" unless _controller_valid?
  end

  def _controller_valid?
    self.controller && self.controller.is_a?(ActionController::Base)
  end

  def _validators
    @_validators ||= self.class.namespace_stackable(:validations).map(&:create_validator)
  end

  def _validate_params!
    exceptions = []

    _validators.each do |v|
      begin
        v.validate!(controller.params.to_unsafe_hash)
      rescue => e
        case e
        when Grape::Exceptions::Validation
          exceptions << e
          break if v.fail_fast?
        when Grape::Exceptions::ValidationArrayErrors
          exceptions += e.errors
          break if v.fail_fast?
        else
          raise e
        end
      end
    end

    raise Entrance::Exceptions::ValidationErrors, errors: exceptions if exceptions.any?
  end

  def _configure_params!
    route_setting(:saved_declared_params, self.class.namespace_stackable(:declared_params))
  end

  def _declared_params
    self.class.namespace_stackable(:declared_params).flatten
  end

  def _declared_param_provided?(param)
    _declared_params.include?(param) && params[param]
  end
end