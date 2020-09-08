require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    context 'common' do
      it {should validate_presence_of(:name)}
      it {should validate_presence_of(:email)}
      it {should validate_presence_of(:password)}
    end
  
    context 'name' do
      it {should allow_value('xx').for(:name)}
      it {should allow_value('國國國國國國國國國').for(:name)}
      it {should allow_value('國國國國 國國國國國').for(:name)}
      it {should allow_value('x' * 50).for(:name)}
      it {should allow_value('my name is Frank').for(:name)}
      it {should_not allow_value('x' * 51).for(:name)}
      it {should_not allow_value('').for(:name)}
      it {should_not allow_value('a').for(:name)}
      InvalidFormats::HALF_SHAPE_PUNCTUATIONS.each do |punctuation|
        it {should_not allow_value(punctuation * 5).for(:name)}
        it {should_not allow_value(punctuation + 'xxx').for(:name)}
      end
    end
  
    context 'email' do
      it {should allow_value('x1@x1.x1').for(:email)}
      it {should allow_value('x1@x1.x1.x1').for(:email)}
      it {should allow_value('x1_x1@x1.x1').for(:email)}
      it {should allow_value('x1_x1.x1_x1@x1_x1.x1_x1').for(:email)}
      it {should allow_value('x1-x1.x1-x1@x1-x1.x1-x1').for(:email)}
      it {should_not allow_value('x1').for(:email)}
      it {should_not allow_value('x1@x1').for(:email)}
      it {should_not allow_value('x1@x1_x1').for(:email)}
      it {should_not allow_value('x1@x1-x1').for(:email)}
      it {should_not allow_value('x1__x1@x1.x1').for(:email)}
      it {should_not allow_value('x1--x1@x1.x1').for(:email)}
      it {should_not allow_value('_x1@x1.x1').for(:email)}
      it {should_not allow_value('-x1@x1.x1').for(:email)}
      it {should_not allow_value('x1@_x1.x1').for(:email)}
      it {should_not allow_value('x1@-x1.x1').for(:email)}
      it {should_not allow_value('x1@x1._x1').for(:email)}
      it {should_not allow_value('x1@x1.-x1').for(:email)}
      it {should_not allow_value('x1..x1@x1.x1').for(:email)}
      before do
        create(:user, email: 'xx@xx.xx')
      end
      it 'should be invalid' do
        expect(User.new(name: 'aa', email: 'xx@xx.xx')).not_to be_valid
      end
    end

    context 'password' do
      it {should allow_value('******').for(:password)}
      it {should allow_value('*' * 20).for(:password)}
      it {should_not allow_value('*****').for(:password)}
      it {should_not allow_value('*' * 21).for(:password)}
    end
  end

  describe 'login' do
    let(:user) { create(:user) }
    it 'should be success' do
      expect(!!user.authenticate('111111')).to eq true
    end
  end
end