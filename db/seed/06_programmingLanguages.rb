# ruby encoding: utf-8
ProgrammingLanguage.destroy_all
15.times do
  ProgrammingLanguage.create!(
    name: Faker::Job.key_skill
  )
end