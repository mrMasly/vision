import { normalize } from 'path'

__modules = {}

Meteor._publish = Meteor.publish
Meteor.publish = (mod, name, args...) ->

  unless typeof mod is 'object'
    args.unshift name
    name = mod
    Meteor._publish name, args...
  else
    Meteor.registerModule mod
    cb = args.pop()
    _name = mod.id
      .replace '/node_modules/meteor/mrmasly:vision/app', 'vision'
      .replace '/app/', 'app/'
      .replace '/index.coffee.js', ''
      .replace '.js', ''
      .replace '.coffee', ''
    name = "#{_name}--publish--#{name}"
    # console.log name
    __modules[name] = mod
    # оборачиваем в функцию, которая проверяет права доступа
    newCb = ->
      if __modules[name].access @userId
        # возвращаем cb, с привязанным this
        return cb.apply @, arguments
      else return null

    args.push newCb

    Meteor._publish name, args...
