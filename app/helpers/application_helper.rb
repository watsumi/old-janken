module ApplicationHelper
  def is_game_page?
    !(current_page?(root_path) || current_page?(rules_path) || current_page?(terms_path) || current_page?(credits_path) || current_page?(privacy_policy_path))
  end

  def icon(icon_name)
    tag.i(class: ["bi", "bi-#{icon_name}"])
  end

  def icon_with_text(icon_name, text)
    tag.span(icon(icon_name), class: "me-2") + tag.span(text)
  end

  def turbo_stream_flash
    turbo_stream.append "flashes", partial: "flash"
  end

  def turbo_stream_background
    turbo_stream.replace "background", partial: "background"
  end
end
