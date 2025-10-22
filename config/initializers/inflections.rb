# Be sure to restart your server when you modify this file.

# Add new inflection rules using the following format. Inflections
# are locale specific, and you may define rules for as many different
# locales as you wish. All of these examples are active by default:
# ActiveSupport::Inflector.inflections(:en) do |inflect|
#   inflect.plural /^(ox)$/i, "\\1en"
#   inflect.singular /^(ox)en/i, "\\1"
#   inflect.irregular "person", "people"
#   inflect.uncountable %w( fish sheep )
# end

# These inflection rules are supported but not enabled by default:
# ActiveSupport::Inflector.inflections(:en) do |inflect|
#   inflect.acronym "RESTful"
# end

Rails.application.config.to_prepare do
  # 質問形式の日本語化
  I18n.backend.store_translations(:ja, {
    enums: {
      question: {
        question_type: {
          multiple_choice: "択一選択",
          free_text: "自由記述",
          multiple_choice_and_free_text: "択一選択と自由記述"
        }
      }
    }
  })
end
