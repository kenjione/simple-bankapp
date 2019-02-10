User.destroy_all

user1 = User.create(email: 'foo@example.com', password: 'qweasdzxc')
user2 = User.create(email: 'bar@example.com', password: 'qweasdzxc')

Credit.new(receiver_id: user1.account.id, amount: 100000).call
Transfer.new(sender_id: user1.account.id, receiver_id: user2.account.id, amount: 4000).call