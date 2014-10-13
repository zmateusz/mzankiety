module ApplicationHelper
  def title(value)
    unless value.nil?
      @title = "#{value} | Mzankiety"      
    end
  end
end
