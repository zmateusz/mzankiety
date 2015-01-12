#encoding: utf-8 
# Generated with RailsBricks
# Initial seed file to use with Devise User Model

User.delete_all
Poll.delete_all
Answer.delete_all
Vote.delete_all
Survey.delete_all

poll1 = Poll.create(name: 'Czy brałeś/łaś udział w wyborach samorządowych 2014?', author: 'admin', descr: 'testowa sonda', typ: 'Radio')
Answer.create(option: 'Tak', poll_id: poll1.id, counter: 0)
Answer.create(option: 'Nie', poll_id: poll1.id, counter: 0)

poll2 = Poll.create(name: 'Podaj swój wiek', author: 'admin', descr: 'testowa sonda 2', typ: 'Text')

poll3 = Poll.create(name: 'Twoj ulubiony kolor?', author: 'admin', descr: 'testowa sonda 3', typ: 'Checkbox')
Answer.create(option: 'biały', poll_id: poll3.id)
Answer.create(option: 'czarny', poll_id: poll3.id)
Answer.create(option: 'czerwony', poll_id: poll3.id)
Answer.create(option: 'niebieski', poll_id: poll3.id)
Answer.create(option: 'zielony', poll_id: poll3.id)
Answer.create(option: 'żółty', poll_id: poll3.id)

# Temporary admin account
u = User.new(
    username: "admin",
    email: "admin@example.com",
    password: "1234",
    password_confirmation: "1234",
    admin: true
)
#u.skip_confirmation!
u.save!



# Test user accounts
(1..5).each do |i|
  u = User.new(
      username: "user#{i}",
      email: "user#{i}@example.com",
      password: "1234",
      password_confirmation: "1234"
  )
  #u.skip_confirmation!
  u.save!

  puts "#{i} test users created..." if (i % 5 == 0)

end
  

