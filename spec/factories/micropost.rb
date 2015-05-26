
FactoryGirl.define do
    factory :micropost do
    	content "My string"
        association :user
    end
end