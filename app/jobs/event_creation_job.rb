class EventCreationJob < ApplicationJob
  queue_as :default

  def perform args={}
    return unless args[:event].present? && args[:email].present?

    event = {name: "Event #{args[:event].upcase}", etype: args[:event]}
    user_email = args[:email]

    request = ExternalApi::Iterable::Request::Event.new(event_name: event[:name], user_email: user_email)
    handler = ExternalApi::Iterable::Handler.new(request: request)
    response = handler.submit!

    # If event created successfully, enqueue job to send email for every Event B 
    if response&.code == "Success"
      EmailDeliveryJob.perform_later({email: user_email}) if event[:etype] == "b"
    end
  end
end
