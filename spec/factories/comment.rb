FactoryGirl.define do
    factory :comment do
    	content "My string"
        user_id   1
        micropost_id  1
    end
end