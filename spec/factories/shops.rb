FactoryBot.define do
  factory :shop do
    name { "MyString" }
    admin {create(:user)}
  end
end
