require 'rails_helper'

RSpec.describe Shop, type: :model do
  let!(:admin){create(:user)}
  let!(:shop){create(:shop, admin: admin)}
  let(:user){create(:user)}
  let(:users){create_list(:user, 2)}

  describe 'validation' do
    it {should validate_presence_of(:admin)}
    it {should validate_presence_of(:name)}
  end

  describe 'association methods' do
    context 'admin' do
      it 'should call admin correct' do
        expect(shop.admin).to eq admin
      end

      it 'should change admin' do
        expect(shop.hr.change_admin(user)).to eq true
        expect(shop.admin).to eq user
        expect(shop.admin).not_to eq admin
      end

      it 'should change admin to someone kicked before' do
        shop.hr.add_staff(user)
        shop.hr.kick_member(user)
        expect(shop.hr.change_admin(user)).to eq true
      end
    end

    context 'staff' do
      it 'should add multiple staff success' do
        users.each do |user|
          expect(shop.hr.add_staff(user)).to eq true
        end
        expect(shop.staffs.count).to eq 2
      end

      it 'should add back staff after kick out' do
        shop.hr.add_staff(user)
        shop.hr.kick_member(user)
        expect(shop.hr.add_staff(user)).to eq true
      end
    end
    context 'customer' do
      it 'should add multiple customer success' do
        users.each do |user|
          expect(shop.hr.add_customer(user)).to eq true
        end
        expect(shop.customers.count).to eq 2
      end    
    end

    context 'kickout' do
      it 'should kick member success' do
        users.each do |user|
          expect(shop.hr.add_staff(user)).to eq true
          expect(shop.hr.kick_member(user)).to eq true
        end
        expect(shop.staffs.count).to eq 0
      end  
    end
  end
end
