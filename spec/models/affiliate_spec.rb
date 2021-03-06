require 'rails_helper'

RSpec.describe Affiliate, type: :model do
  describe 'associations' do
    it 'should have many coordinators' do
      should have_many(:coordinators)
    end

    it 'should have many volunteer_jobs' do
      should have_many(:volunteer_jobs)
    end

    it 'should have many tutors through volunteer_jobs' do
      should have_many(:tutors).through(:volunteer_jobs)
    end

    it 'should have many enrollments' do
      should have_many(:enrollments)
    end

    it 'should have many students through enrollments' do
      should have_many(:students).through(:enrollments)
    end
  end

  describe 'validations' do
    describe 'validate email' do
      it 'email presence' do
        should validate_presence_of(:email)
      end

      it 'email length' do
        should validate_length_of(:email)
          .is_at_most(255)
      end

      it 'email format' do
        should allow_value('email@email.com').for(:email)
        should_not allow_value('foo').for(:email)
        should_not allow_value('foo@').for(:email)
        should_not allow_value('foo@address').for(:email)
        should_not allow_value('address.foo').for(:email)
      end

      it 'email uniqueness' do
        should validate_uniqueness_of(:email).case_insensitive
      end
    end

    describe 'validate name' do
      it 'name presence' do
        should validate_presence_of(:name)
      end

      it 'name length' do
        should validate_length_of(:name)
          .is_at_most(100)
      end
    end

    describe 'validate address' do
      it 'address presence' do
        should validate_presence_of(:address)
      end

      it 'address length' do
        should validate_length_of(:address)
          .is_at_most(200)
      end
    end

    describe 'validate phone number' do
      it 'phone number presence' do
        should validate_presence_of(:phone_number)
      end

      it 'phone number length' do
        should validate_length_of(:phone_number)
          .is_at_most(14)
      end
    end

    describe 'state' do
      it 'validates presence' do
        should validate_presence_of(:state)
      end
    end

    describe 'city' do
      it 'validates presence' do
        should validate_presence_of(:city)
      end
    end

    describe 'zip' do
      it 'validates presence' do
        should validate_presence_of(:zip)
      end

      it 'validates format' do
        should allow_value('03923').for(:zip)
        should allow_value('54321').for(:zip)
        should_not allow_value('1234').for(:zip)
        should_not allow_value('123456').for(:zip)
        should_not allow_value('abcde').for(:zip)
      end
    end
  end

  describe 'methods' do
    describe 'full_address' do
      it 'returns the full address' do
        a = create(:affiliate)
        expect(a.full_address)
          .to eq("#{a.address}, #{a.city} #{a.state}, #{a.zip}")
      end
    end
  end
end
