Meteor.__attachedModules = []
Meteor.attach = (mod) ->
  Meteor.__attachedModules.push mod
