import { normalize } from 'path'

Module = module.parent

__modules = {}

Meteor._methods = Meteor.methods
Meteor.methods = (mod, methods) ->
  unless methods?
    Meteor._methods mod
  else
    for method, cb of methods
      do =>
        cb1 = cb
        _name = mod.id
          .replace '/node_modules/meteor/mrmasly:vision/components', 'vision'
          .replace '/components/', 'app/'
          .replace '/index.coffee.js', ''
          .replace '.js', ''
          .replace '.coffee', ''
        name = "#{_name}--method--#{method}"
        __modules[name] = mod
        newCb = ->
          if __modules[name].access @userId
            # возвращаем cb, с привязанным this
            return cb1.apply @, arguments
          else return null
        Meteor._methods
          "#{name}": newCb
