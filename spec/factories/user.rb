FactoryGirl.define do
	sequence(:email, 1000) {|n| "person#{n}@example.com" }
    factory :user do
     name "anshu"
     password "rubyrails"
     password_confirmation "rubyrails"
     email { FactoryGirl.generate(:email) }
     
  end
end 
