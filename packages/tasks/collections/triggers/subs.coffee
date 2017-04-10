import _ from 'lodash'

module.exports = (userId, doc, fields, mod, options) ->
  # пользо если есть изменения в подзадачах
  return null unless 'subs' in fields
  return null if _.isEmpty mod.$set.subs
  done = yes
  for sub in mod.$set.subs
    unless sub.done
      done = no

  if done isnt doc.done
    fields.push 'done' unless 'done' in fields
    mod.$set.done = done
