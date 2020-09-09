require 'rails_helper'

RSpec.describe Shop::Role, type: :model do
  describe 'validation' do
    it { should validate_presence_of(:user_id)}
    it { should validate_presence_of(:shop_id)}
    it { should validate_presence_of(:role)}
    it { should validate_inclusion_of(:role).in_array(%w(admin customer staff))}
  end
end
