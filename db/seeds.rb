#encoding: utf-8 
# Generated with RailsBricks
# Initial seed file to use with Devise User Model

User.delete_all
Vote.delete_all
Answer.delete_all
Poll.delete_all
Survey.delete_all

poll1 = Poll.create(name: 'Czy brałeś/łaś udział w wyborach samorządowych 2014?', 
                    descr: 'testowa sonda', 
                    author: 'user1', shared: true, votable: true, typ: 'Radio')
a1 = Answer.create(option: 'Tak', poll_id: poll1.id, counter: 3)
a2 = Answer.create(option: 'Nie', poll_id: poll1.id, counter: 1)
Vote.create(author: 'anonim', custom: a1.option, answer_id: a1.id, poll_id: poll1.id)
Vote.create(author: 'user1', custom: a1.option, answer_id: a1.id, poll_id: poll1.id)
Vote.create(author: 'user2', custom: a1.option, answer_id: a1.id, poll_id: poll1.id)
Vote.create(author: 'user3', custom: a2.option, answer_id: a2.id, poll_id: poll1.id)

poll2 = Poll.create(name: 'Ulubione filmy', 
                    descr: 'Wypisz kilka ulubionych filmów', 
                    author: 'user1', shared: true, votable: true, typ: 'Text')
a3 = Answer.create(option: 'custom', poll_id: poll2.id, counter: 0)
Vote.create(author: 'user1', custom: 'Forrest Gump, Gran Torino, Django', 
            answer_id: a3.id, poll_id: poll2.id)
Vote.create(author: 'user2', custom: 'Shrek, Zielona mila, Gladiator', 
            answer_id: a3.id, poll_id: poll2.id)

poll3 = Poll.create(name: 'Systemy operacyjne', 
                    descr: 'Z jakich systemów korzystasz?', 
                    author: 'user1',shared: true, votable: true, typ: 'Checkbox')
a4 = Answer.create(option: 'Android', poll_id: poll3.id, counter: 2)
a5 = Answer.create(option: 'Linux', poll_id: poll3.id, counter: 1)
a6 = Answer.create(option: 'Mac OS', poll_id: poll3.id, counter: 1)
a7 = Answer.create(option: 'Windows', poll_id: poll3.id, counter: 3)
Vote.create(author: 'user1', custom: 'Android, Windows', 
            answer_id: a7.id, poll_id: poll3.id)
Vote.create(author: 'user1', custom: 'Android, Windows', 
            answer_id: a7.id, poll_id: poll3.id)
Vote.create(author: 'user2', custom: 'Linux, Mac OS', 
            answer_id: a7.id, poll_id: poll3.id)
Vote.create(author: 'user2', custom: 'Windows', 
            answer_id: a7.id, poll_id: poll3.id)

surv1 = Survey.create(name: 'Ankieta samochodowa',
                      descr: 'ankieta testowa',
                      author: 'user1',shared: true, votable: true)
poll4 = Poll.create(name: 'Jakie paliwo tankujesz do swojego auta?', 
                    descr: 'Możesz udzielić jednej odpowiedzi', 
                    author: 'user1', typ: 'Radio', survey_id: surv1.id)
a8 = Answer.create(option: '95', poll_id: poll4.id, counter: 0)
a9 = Answer.create(option: '98', poll_id: poll4.id, counter: 2)
a10 = Answer.create(option: 'ON', poll_id: poll4.id, counter: 0)
a11 = Answer.create(option: 'Gaz', poll_id: poll4.id, counter: 1)
Vote.create(author: 'user1', custom: a9.option, answer_id: a9.id, poll_id: poll4.id, voter: 1)
Vote.create(author: 'user2', custom: a9.option, answer_id: a9.id, poll_id: poll4.id, voter: 2)
Vote.create(author: 'user3', custom: a11.option, answer_id: a11.id, poll_id: poll4.id, voter: 3)
poll5 = Poll.create(name: 'Do czego na co dzień używasz swojego samochodu?', 
                    descr: 'Możesz udzielić wielu odpowiedzi', 
                    author: 'user1', typ: 'Checkbox', survey_id: surv1.id)
a12 = Answer.create(option: 'Dojazd do pracy', poll_id: poll5.id, counter: 1)
a13 = Answer.create(option: 'To moje narzędzie pracy', poll_id: poll5.id, counter: 1)
a14 = Answer.create(option: 'Wożę rodzinę na zakupy i wycieczki', poll_id: poll5.id, counter: 1)
a15 = Answer.create(option: 'Żeby się pokazać', poll_id: poll5.id, counter: 1)
a16 = Answer.create(option: 'Używam samochodu sporadycznie', poll_id: poll5.id, counter: 1)
Vote.create(author: 'user1', custom: 'Dojazd do pracy, Wożę rodzinę na zakupy i wycieczki', 
            answer_id: a16.id, poll_id: poll5.id, voter: 1)
Vote.create(author: 'user2', custom: 'To moje narzędzie pracy', 
            answer_id: a16.id, poll_id: poll5.id, voter: 2)
Vote.create(author: 'user3', custom: 'Żeby się pokazać, Używam samochodu sporadycznie', 
            answer_id: a16.id, poll_id: poll5.id, voter: 3)
poll6 = Poll.create(name: 'Jaki samochód posiadasz? (marka, model)', 
                    descr: 'Wpisz własną odpowiedź', 
                    author: 'user1', typ: 'Text', survey_id: surv1.id)
a17 = Answer.create(option: 'custom', poll_id: poll6.id, counter: 0)
Vote.create(author: 'user1', custom: 'Seat Ibiza', 
            answer_id: a17.id, poll_id: poll6.id, voter: 1)
Vote.create(author: 'user2', custom: 'VW Golf', 
            answer_id: a17.id, poll_id: poll6.id, voter: 2)
Vote.create(author: 'user3', custom: 'Mitsubishi Lancer', 
            answer_id: a17.id, poll_id: poll6.id, voter: 3)
poll7 = Poll.create(name: 'Dziekuję za wypełnienie ankiety.', 
                    descr: '', 
                    author: 'user1', typ: 'Info', survey_id: surv1.id)

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
  

