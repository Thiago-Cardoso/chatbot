FactoryBot.define do
    factory :hashtag do
       name FFaker::Lorem.word #create a name randomic for company and associated with hashtag
       company
    end
end
