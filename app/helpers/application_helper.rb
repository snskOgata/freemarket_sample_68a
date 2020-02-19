module ApplicationHelper

  def show_errors(model, error_key)
    if model.errors.messages[error_key].present?
      model.errors.messages[error_key]
    end
    return model.errors.messages[error_key]
  end

end
