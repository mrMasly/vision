import Fiber from 'fibers'

Fiber ->
  # создаем пользователя по умолчанию
  if Meteor.users.find().count() is 0
    Accounts.createUser
      username: 'admin'
      profile: name: 'admin'
      password: '123456'

.run()
