#encoding: utf-8
module SurveysHelper

  def shared_survey(survey)
    if survey.shared == true
      "Udostępniona - #{link_to 'Ukryj', setshared_survey_path(@survey), method: 'get'}" 
    else
      "Ukryta - #{link_to 'Udostępnij', setshared_survey_path(@survey), method: 'get'}"
    end
  end

  def votable_survey(survey)
    if survey.votable == true
      "Otwarta - #{link_to 'Zamknij', setvotable_survey_path(@survey), method: 'get'}" 
    else
      "Zamknięta - #{link_to 'Otwórz', setvotable_survey_path(@survey), method: 'get'}"
    end
  end

end
