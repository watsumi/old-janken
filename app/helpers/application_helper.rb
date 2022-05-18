module ApplicationHelper
  def default_meta_tags
    {
      site: '旧約じゃんけん',
      title: '旧約じゃんけん',
      reverse: true,
      charset: 'utf-8',
      description: 'ルールがちょっと複雑なじゃんけんゲーム。',
      keywords: '旧約じゃんけん,old-janken',
      canonical: request.original_url,
      separator: '|',
      icon: [
        { href: "#{root_url}favicon.ico" },
        { href: "#{root_url}apple-touch-icon.png", rel: 'apple-touch-icon', sizes: '180x180', type: 'image/png' },
      ],
      og: {
        site_name: :site,
        title: :title,
        description: :description,
        type: 'website',
        url: request.original_url,
        image: "#{root_url}ogp.png",
        locale: 'ja_JP',
      },
      twitter: {
        site_name: :site,
        title: :title,
        description: :description,
        card: 'summary_large_image',
        site: '@old-janken',
        image: "#{root_url}ogp.png",
      },
    }
  end

  def is_game_detail_page?
    !(current_page?(root_path) || current_page?(rules_path) || current_page?(terms_path) || current_page?(credits_path) || current_page?(privacy_policy_path) | current_page?(games_path) | current_page?(paticipates_game_path))
  end

  def icon(icon_name)
    tag.i(class: ['bi', "bi-#{icon_name}"])
  end

  def icon_with_text(icon_name, text)
    tag.span(icon(icon_name), class: 'me-2') + tag.span(text)
  end

  def turbo_stream_flash
    turbo_stream.append 'flashes', partial: 'flash'
  end

  def turbo_stream_background
    turbo_stream.replace 'background', partial: 'background'
  end
end
