module ExternalApi
	module Iterable
		module Request
			class Event
				include Base

				attr_reader :event_name, :user_email

				def initialize event_name: nil, user_email: nil
					@event_name = event_name
					@user_email = user_email
				end

				def valid?
					event_name.present? && user_email.present?
				end

				def body
					{
					  "email": user_email,
					  "eventName": event_name
					}
				end

				def endpoint
					ExternalApi::Iterable::Constant::Endpoint::EVENT
				end
			end
		end
	end
end
