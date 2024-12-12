require 'rails_helper'

RSpec.describe User, type: :model do
  subject { described_class.new(username: 'testuser', password: 'Password1!') }

  describe 'Validations' do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid without a username' do
      subject.username = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid with an invalid username' do
      subject.username = 'invalid username'
      expect(subject).to_not be_valid
    end

    it 'is not valid without a password' do
      subject.password = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid with a short password' do
      subject.password = 'Short1!'
      expect(subject).to_not be_valid
    end

    it 'is not valid with a password missing an uppercase letter' do
      subject.password = 'password1!'
      expect(subject).to_not be_valid
    end

    it 'is not valid with a password missing a lowercase letter' do
      subject.password = 'PASSWORD1!'
      expect(subject).to_not be_valid
    end

    it 'is not valid with a password missing a number' do
      subject.password = 'Password!'
      expect(subject).to_not be_valid
    end

    it 'is not valid with a password missing a special character' do
      subject.password = 'Password1'
      expect(subject).to_not be_valid
    end
  end
end
