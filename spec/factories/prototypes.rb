FactoryBot.define do
  factory :prototype do
    title {Faker::Lorem.word}
    catch_copy {Faker::Lorem.sentence}
    concept {Faker::Lorem.sentence}
    association :user

    after(:build) do |prototype|
      prototype.image.attach(io: File.open('public/images/test.png'), filename: 'test.png')
    end
  end
end