module PollsHelper

  def status_poll(poll)
    if poll.shared == true
      "Widoczna - #{link_to 'Ukryj', togglep_poll_path(@poll), method: 'get'}" 
    else
      "Ukryta - #{link_to 'Udostepnij', togglep_poll_path(@poll), method: 'get'}"
    end
  end

end
