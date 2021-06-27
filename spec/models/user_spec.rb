require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to be_mongoid_document }
  it { is_expected.to have_field(:email).of_type(String)}
  it { is_expected.to validate_uniqueness_of(:email)}
  
  describe "created user" do
   it "valid user" do 
    user = build(:user)
    expect {
      user.save!
    }.to change {User.count}.from(0).to(1)
   end

   it "invalid email" do 
    user_one = build(:user,email: nil)
    user_two = build(:user,email: "teste.com")

    expect(user_one.save).to eq(false)
    expect(user_two.save).to eq(false)
   end

   it "email duplicated" do 
    email = Faker::Internet.email
    user1 = create(:user,email: email)
    user2 = build(:user,email: email)

    expect(user2.save).to eq(false)
   end

   it "invalid password" do 
    user = build(:user, password: nil)
    expect(user.save).to eq(false)
   end
  end
  
end
