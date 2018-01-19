# Rentrance
Guard Your Rails Controller Actions with Grape Parameter Validations.

## Usage

An entrance can serve the purpose of a single API endpoint. [Grape Pamaeters Validations](https://github.com/ruby-grape/grape) is integrated:
```ruby
class Index < Rentrance::Base
  params do
    requires :req_param, type: String
    optional :opt_param, type: Integer
  end

  # A :perform method is standard to define what the controller action will actually be doing.
  # The following methods will be deletegated to the controller context:
  # - render
  # - render_partial
  # - redirect_to
  # - request
  # The perform method mimicks the experience of implementing a controller method in the
  # action controller.
  def perform
    render json: { req: params[:req_param], opt: params[:opt_param] }, status: 200
  end

private

  # The params are also supported to be naked, as it will first try to direct the message
  # to :params before raising a :method_missing exception
  def parse_params
    {
      key: req_param,
      val: opt_param
    }
  end
end
```

After you have created an entrance, you just need to hook it up with your controller:
```ruby
class SomeController < ActionController
  def index
    Index.new(controller: self).perform
  end
end
```

## NOTE
- Currently, setting up instance variables like we do in a controller before rendering a template
  is NOT supported.
