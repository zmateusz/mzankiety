#encoding: utf-8
module PollsHelper

  def shared_poll(poll)
    if poll.shared == true
      "Udostępniona - #{link_to 'Ukryj', setshared_poll_path(@poll), method: 'get'}" 
    else
      "Ukryta - #{link_to 'Udostępnij', setshared_poll_path(@poll), method: 'get'}"
    end
  end

  def votable_poll(poll)
    if poll.votable == true
      "Otwarta - #{link_to 'Zamknij', setvotable_poll_path(@poll), method: 'get'}" 
    else
      "Zamknięta - #{link_to 'Otwórz', setvotable_poll_path(@poll), method: 'get'}"
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