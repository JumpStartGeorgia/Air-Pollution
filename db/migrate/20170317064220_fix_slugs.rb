class FixSlugs < ActiveRecord::Migration
  def up
    orig_locale = I18n.locale

    Story.transaction do
      I18n.available_locales.each do |locale|
        I18n.locale = locale

        Pledge.all.each do |p|
          if p.title.present?
            p.slug = p.title.to_url
            p.save
          end
        end

        Story.all.each do |s|
          if s.title.present?
            s.slug = s.title.to_url
            s.save
          end
        end

      end
    end

    I18n.locale = orig_locale
  end

  def down
    puts 'do nothing'
  end
end
