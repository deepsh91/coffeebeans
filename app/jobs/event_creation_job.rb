class EventCreationJob < ApplicationJob

  def perform(args={})
    return unless args[:event].present? && args[:email].present?

    puts "Making API call with params: Event #{args[:event]} and email #{args[:email]}"
  end
end
