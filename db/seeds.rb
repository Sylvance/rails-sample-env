# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

def create_dummy_companies(number: 3)
  (number - Company.all.size).times do
    Company.create({ name: Faker::Company.name })
  end
end

def create_dummy_data(company:)
  create_users(company: company)
  create_customers(company: company)
  create_questions(company: company)
  create_surveys(company: company)
end

def create_users(company:, number: 3)
  (number - company.users.count).times do
    company.users.create(name: Faker::Name.name).tap do |user|
      user.set_api_credentials
    end.save
  end
end

def create_customers(company:, number: 10)
  (number - company.customers.count).times do
    company.customers.create(name: Faker::Restaurant.name)
  end
end

def create_questions(company:, number: 3)
  (number - company.questions.count).times do
    company.questions.create(question: "#{Faker::Lorem.sentence}?")
  end
end

def create_surveys(company:, number: 20)
  number.times do
    company.surveys.create(
      user: company.users.sample,
      customer: company.customers.sample,
      note: Faker::Lorem.paragraph(sentence_count: 2),
      created_at: Faker::Time.between(from: 1.month.ago, to: 1.month.since)
    ).tap do |survey|
      company.questions.each do |question|
        survey.answers.create(
          question: question,
          answer: Faker::Lorem.word,
          created_at: survey.created_at
        )
      end
    end
  end
end

create_dummy_companies
Company.all.each{ |company| create_dummy_data(company: company)}
