#encoding: utf-8 
module PollsHelper

  def status_poll(poll)
    if poll.shared == true
      "Widoczna - #{link_to 'Ukryj', togglep_poll_path(@poll), method: 'get'}" 
    else
      "Ukryta - #{link_to 'Udostepnij', togglep_poll_path(@poll), method: 'get'}"
    end
  end

  def typeinfo(typ)
    if typ == "Radio"
      "Wybór jednokrotny"
    elsif typ == "Checkbox"
      "Wybór wielokrotny"
    elsif typ == "Text"
      "Dowolny tekst"
    elsif typ == "Info"
      "Puste pytanie"
    end
  end

end