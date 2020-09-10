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
        expect(shop.reload.admin).to eq admin
       end

      it 'should change admin' do
        expect(shop.admin = user).to eq user
        expect(shop.reload.admin).to eq user
        expect(shop.admin).not_to eq admin
      end

      it 'should change admin to someone kicked before' do
        shop.staffs << user
        shop.staffs.delete user
        shop.admin = user
        expect(shop.reload.admin).to eq user
      end
    end

    context 'staff' do
      it 'should add multiple staff success' do
        users.each do |user|
          shop.staffs << user
          expect(shop.reload.staffs.last).to eq user
        end
        expect(shop.reload.staffs.count).to eq 2
      end

      it 'should add back staff after kick out' do
        shop.staffs << user
        shop.staffs.delete user
        shop.staffs << user
        expect(shop.reload.staffs.last).to eq user
      end
    end
    context 'customer' do
      it 'should add multiple customer success' do
        users.each do |user|
          shop.customers << user
          expect(shop.reload.customers.last).to eq user
        end
        expect(shop.reload.customers.count).to eq 2
      end    
    end

    context 'kickout' do
      it 'should kick member success' do
        users.each do |user|
          shop.staffs << user
          shop.staffs.delete user
        end
        expect(shop.reload.staffs.count).to eq 0
      end  
    end
  end
end
