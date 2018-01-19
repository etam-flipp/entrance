require 'spec_helper'

describe Rentrance::ResponseHelpers do
  let(:controller) { ActionController::Base.new }

  describe 'json' do
    let(:klass) do
      Class.new(Rentrance::Base) do
        include Rentrance::ResponseHelpers::JSON
      end
    end

    describe '#json_render' do
      let(:payload) { Hash.new }
      let(:status) { 200 }

      subject do
        _payload = payload
        _status = status

        klass.class_eval do
          redefine_method(:perform) do
            json_render(_payload, _status)
          end
        end

        klass.new(controller: controller)
      end

      before do
        expect(controller)
          .to receive(:render)
          .with(json: payload, status: status)
          .and_return(nil)
      end

      it 'delegates render to controller with proper params' do
        expect { subject.perform }.not_to raise_error
      end
    end

    describe '#json_error!' do
      let(:payload) { Hash.new }

      subject do
        _payload = payload

        klass.class_eval do
          redefine_method(:perform) do
            json_error!(_payload)
          end
        end

        klass.new(controller: controller)
      end

      before do
        expect(controller)
          .to receive(:render)
          .with(json: payload, status: Rentrance::ResponseHelpers::Statuses::ERROR)
          .and_return(nil)
      end

      it 'delegates render to controller with proper params' do
        expect { subject.perform }.not_to raise_error
      end
    end

    describe '#json_success!' do
      let(:payload) { Hash.new }

      subject do
        _payload = payload

        klass.class_eval do
          redefine_method(:perform) do
            json_success!(_payload)
          end
        end

        klass.new(controller: controller)
      end

      before do
        expect(controller)
          .to receive(:render)
          .with(json: payload, status: Rentrance::ResponseHelpers::Statuses::SUCCESS)
          .and_return(nil)
      end

      it 'delegates render to controller with proper params' do
        expect { subject.perform }.not_to raise_error
      end
    end

    describe '#json_created!' do
      let(:payload) { Hash.new }

      subject do
        _payload = payload

        klass.class_eval do
          redefine_method(:perform) do
            json_created!(_payload)
          end
        end

        klass.new(controller: controller)
      end

      before do
        expect(controller)
          .to receive(:render)
          .with(json: payload, status: Rentrance::ResponseHelpers::Statuses::CREATED)
          .and_return(nil)
      end

      it 'delegates render to controller with proper params' do
        expect { subject.perform }.not_to raise_error
      end
    end
  end
end