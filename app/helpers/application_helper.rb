module ApplicationHelper
  def title(value)
    unless value.nil?
      @title = "#{value} | mzankiety"      
    end
  end
  def dateformat(date)
    date.strftime("%d.%m.%Y - %R")
  end
end
