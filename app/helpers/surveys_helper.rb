module SurveysHelper

  def status_survey(survey)
    if survey.shared == true
      "Widoczna - #{link_to 'Ukryj', toggles_survey_path(@survey), method: 'get'}" 
    else
      "Ukryta - #{link_to 'Udostepnij', toggles_survey_path(@survey), method: 'get'}"
    end
  end

end
