FactoryBot.define do
    factory :faq do
       question FFaker::Lorem.phrase #create a question randomic
       answer FFaker::Lorem.phrase #create a answer
       company #create a faq associated with company
    end
end
