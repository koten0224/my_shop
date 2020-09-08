require 'rails_helper'

RSpec.describe User::Session, type: :model do
  let(:user) { create(:user) }
  context 'should be pass' do
    let(:session) { User::Session.new(email: user.email, password: '111111') }
    it do
      expect(session).to be_valid
      expect(session.user).to eq user
    end
  end
  context 'should not pass' do
    let(:session) { User::Session.new(email: user.email, password: '222222') }
    it do
      expect(session).not_to be_valid
    end
    let(:session) { User::Session.new(email: 'xx@xx.xx', password: '111111') }
    it do
      expect(session).not_to be_valid
    end
  end
end