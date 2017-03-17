import _ from 'lodash'

setTimeout =>

  allow = []

  # получает все права на модули
  init = _.once ->
    for key, value of Meteor.allow
      if _.isString value
        value = groups: [value]
      else if _.isArray value
        value = groups: value
      value.users ?= []
      value.groups ?= []
      allow.push rule: key, access: value
      allow = _.sortBy allow, (a) -> - a.rule.length

  # проходимя по каждому модулю
  modules = []
  Module = module
  while true
    modules.push children for children in Module.children
    if Module.parent
      Module = Module.parent
    else
      break

  # modules = _.union Module.children, Meteor.__attachedModules
  for mod in modules
    # получаем имя модуля
    if mod.id.indexOf('vision/app/') + 1
      mod.name = 'vision/' + mod.id.split('vision/app/')[1]
    else if mod.id.indexOf('/app/') + 1
      mod.name = 'app/' + mod.id.split('/app/')[1]

    unless mod.name?
      mod.access = -> yes
      continue

    mod.allow ?= {}
    mod.allow.users ?= []
    mod.allow.groups ?= []

    # проходимся по всем правилам
    for a in allow
      if mod.name.indexOf(a.rule) is 0
        unless _.isEmpty a.access.users
          mod.allow.users = _.union mod.allow.users, a.access.users
        unless _.isEmpty a.access.groups
          mod.allow.groups = _.union mod.allow.groups, a.access.groups
        break

    # проверяем - доступен ли модуль пользователю
    mod.access ?= (userId) ->
      return no unless userId
      # userId ?= Meteor.userId()
      user = Meteor.users.findOne _id: userId,
        fields:
          username: 1
          groups: 1
      return no unless user?
      if 'all' in @allow.users
        return yes
      if user.username in @allow.users
        return yes
      if _.isArray user.groups
        for group in user.groups
          if group in @allow.groups
            return yes
      return no
