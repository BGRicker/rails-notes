FactoryBot.define do
  factory :note, class: Note do
    title { "Shopping List" }
    content { "Pizza" }
  end
end
