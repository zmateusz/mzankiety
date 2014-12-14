module ApplicationHelper
  def title(value)
    unless value.nil?
      @title = "#{value} | mzankiety"      
    end
  end
end
