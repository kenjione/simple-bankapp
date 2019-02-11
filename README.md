# README

```
> user1 = User.create(email: 'foo@example.com', password: 'qweasdzxc')
> user2 = User.create(email: 'bar@example.com', password: 'qweasdzxc')

> account1 = user1.account
> account2 = user2.account

> Credit.new(receiver_id: account1.id, amount: 100000).call
> Transfer.new(sender_id: account1.id, receiver_id: account2.id, amount: 4000).call
```
