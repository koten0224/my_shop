require 'rails_helper'

RSpec.describe Shop::Role, type: :model do
  describe 'common' do
    it { should validate_presence_of(:user_id)}
    it { should validate_presence_of(:shop_id)}
    it { should validate_presence_of(:role)}
    it { should validate_inclusion_of(:role).in_array(%w(admin customer staff))}
  end

  describe 'role' do
    it { should allow_value('admin').for(:role)}
    it { should allow_value('staff').for(:role)}
    it { should allow_value('customer').for(:role)}
    it { should_not allow_value('dmin').for(:role)}
    it { should_not allow_value('taff').for(:role)}
    it { should_not allow_value('ustomer').for(:role)}
    it { should_not allow_value('admim').for(:role)}
    it { should_not allow_value('steve').for(:role)}
    it { should_not allow_value('custom').for(:role)}
    it { should_not allow_value(nil).for(:role)}
    it { should_not allow_value('').for(:role)}
  end
end
