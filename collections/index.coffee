import _ from 'lodash'
import './Users.coffee'
import './Avatars.coffee'


FS.Collection::_find = FS.Collection::find
FS.Collection::find = (selector={}, options={}) ->

  # если указаны поля - добавляем поля, которые нужны для формирования url
  if options.fields?
    options.fields['_id'] = yes
    options.fields['original.name'] = yes

  if Meteor.isClient

    # копируем пользовательскую функцию transform
    transform = options.transform

    setUrls = _.debounce (doc) ->
      stores = {}
      for store of @storesLookup
        stores[store] = "/cfs/files/#{@name}/#{doc._id}/#{doc.original.name}?store=#{store}"
      doc.store = stores
    , 100
    # назначаем новую transform
    options.transform = (doc) =>
      doc.store = {}
      for store of @storesLookup
        doc.store[store] = "/cfs/files/#{@name}/#{doc._id}/#{doc.original.name}?store=#{store}"
      # выполняем пользовательскую transform
      doc = transform doc if transform
      return doc

  return @_find selector, options


FS.Collection::_findOne = FS.Collection::findOne
FS.Collection::findOne = (selector={}, options={}) ->



  # если указаны поля - добавляем поля, которые нужны для формирования url
  if options.fields?
    options.fields['_id'] = yes
    options.fields['original.name'] = yes

  if Meteor.isClient

    # копируем пользовательскую функцию transform
    transform = options.transform

    setUrls = _.debounce (doc) ->
      stores = {}
      for store of @storesLookup
        stores[store] = "/cfs/files/#{@name}/#{doc._id}/#{doc.original.name}?store=#{store}"
      doc.store = stores
    , 500

    # назначаем новую transform
    options.transform = (doc) =>
      doc.store = {}
      setUrls.call @, doc
      # выполняем пользовательскую transform
      doc = transform doc if transform
      return doc

  return @_findOne selector, options
