class EmailDeliveryJob < ApplicationJob
  queue_as :critical

  def perform args={}
    return unless args[:email].present?

    user_email = args[:email]

    request = ExternalApi::Iterable::Request::Email.new(user_email: user_email)
    handler = ExternalApi::Iterable::Handler.new(request: request)
    handler.submit!
  end
end
