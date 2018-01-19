require 'spec_helper'

describe Rentrance::Base do
  let(:controller) { ActionController::Base.new }

  class Klass < Rentrance::Base
    params do
      requires :req, type: String
      optional :opt, type: String
    end

    def perform
      render :json => 'something', status: 200
    end
  end

  describe 'param validations' do
    context 'when required param is not provided' do
      let(:controller_params) {{ opt: 'something' }}

      before do
        allow(controller_params).to receive(:to_unsafe_hash).and_return(controller_params)
        allow(controller).to receive(:params).and_return(controller_params)
      end

      subject { Klass.new(controller: controller) }
      it 'raises an exception' do
        expect { subject.perform }.to raise_error(Rentrance::Exceptions::ValidationErrors)
      end
    end
  end

  describe 'controller delegations' do
    let(:controller_params) { Hash.new }

    before do
      allow(controller_params).to receive(:to_unsafe_hash).and_return(controller_params)
      allow(controller).to receive(:params).and_return(controller_params)
    end

    subject { Rentrance::Base }
    it 'delegates controller methods to the controller context' do
      Rentrance::Base::CONTROLLER_DELEGATIONS.each do |meth|
        klass = Class.new(subject) do
          redefine_method(:perform) { send(meth) }
        end

        expect(controller).to receive(meth).and_return(nil)
        klass.new(controller: controller).perform
      end
    end
  end
end