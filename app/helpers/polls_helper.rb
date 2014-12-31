module PollsHelper

  def status(poll)
    if poll.shared == true
      "Widoczna - #{link_to 'Ukryj', toggle_poll_path(@poll), method: 'get'}" 
    else
      "Ukryta - #{link_to 'Udostepnij', toggle_poll_path(@poll), method: 'get'}"
    end
  end

end
