class HomeController < ApplicationController
  
  # Storing simple counter in session to display on UI
  def index
    # Initialize counter
    if session[:event_counter].nil?
      session[:event_counter] = {"a" => 0, "b" => 0}
    end

    @counter = session[:event_counter]

    render
  end

  def event
    begin
      event = params[:event]

      if event == "a" || event == "b"
        EventCreationJob.perform_later({event: event, email: current_user.email})

        # Increment corresponding counter
        session[:event_counter][event] = session[:event_counter][event] + 1
        @counter = session[:event_counter]

        flash.notice = "Enqueued job for Event #{event.upcase}"
      end
    rescue => ex
      flash.alert = "An error occurred!"
    end

    respond_to do |format|
      format.html { render 'index'}
    end
  end
end
