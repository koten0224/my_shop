FactoryBot.define do
  factory :shop_role, class: 'Shop::Role' do
    user { create(:user) }
    shop { create(:shop) }
    role { "admin" }
  end
end
