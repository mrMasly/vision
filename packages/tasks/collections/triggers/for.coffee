
module.exports = (userId, doc, fields, mod) ->
  unless fields?
    insert arguments...
  else
    update arguments...

insert = (userId, doc) ->
  doc.for ?= userId

update = (userId, doc, fields, mod) ->
  if not doc.for? and not mod.$set.for?
    mod.$set.for = userId
