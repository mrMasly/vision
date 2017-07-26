import _ from 'lodash'

export default (user) ->

  do Meteor.wrapAsync (done) ->

    if user._id then make = update
    else make = insert
    make user, done



update = (user, done) ->
  # меняем пароль
  if user.password
    if user.password.length < 6
      throw new Meteor.Error 'Пароль слишком короткий'
    else
      Accounts.setPassword user._id, user.password
  # _user = Accounts.users.findOne _id: user._id
  data = {}
  data['username'] = user.username
  data['profile.name'] = user.profile.name
  data['groups'] = user.groups
  data['store'] = user.store
  Accounts.users.update user._id, $set: data, (err, res) ->
    if err?
      error = "Ошибка при изменении данных пользователя"
      done null, error
    else
      done null, user._id



insert = (user, done) ->
  id = Accounts.createUser user
  unless id?
    error = message: "Ошибка при создании пользователя"
    done null, error
  else
    user = _.omit user, 'password'
    user._id = id
    update user, done
