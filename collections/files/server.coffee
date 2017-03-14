import _ from 'lodash'
import Fiber from 'fibers'
import fs from 'fs'
import fse from 'fs-extra'
import gm from 'gm'

collections = {}


mkdir = (dir) ->
  fiber = Fiber.current
  fse.mkdirs dir, (err) -> fiber.run !err
  do Fiber.yield

write = (name, binary) ->
  fiber = Fiber.current
  fs.writeFile name, binary, 'binary', (err) -> fiber.run !err
  do Fiber.yield

resize = (name, binary, size) ->
  fiber = Fiber.current
  fs.writeFile name, binary, 'binary', (err) ->
    return fiber.run no if err
    gm(name).resize(size[0], size[1], '!').noProfile().write name, (err) ->
      fiber.run !err
  do Fiber.yield


Meteor.methods
  "__file__upload__": (name, binary, collection, type) ->
    async = Async.runSync (done) ->
      # сохраняем папку и url для этой коллекции
      data = collections[collection]
      # генерируем id
      id = Random.id()
      # определяем папку и url
      dir = "#{data.dir}/#{id}"
      url = "#{data.url}/#{id}"
      return done "error mkdir" unless mkdir dir
      # определяем расширение файла
      ext = name.split('.'); ext = ext[ext.length-1]
      # определяем какие файлы нужно сохранять
      stores = original: null
      if data.stores?
        for name, action of data.stores
          stores[name] = action

      # проходимся по каждому хранилищу
      res = {}
      for name, action of stores
        res[name] = "#{id}/#{name}.#{ext}"
        filename = "#{dir}/#{name}.#{ext}"
        unless action?
          return done "error write #{filename}" unless write filename, binary
        else if _.isArray action
          return done "error write #{filename}" unless resize filename, binary, action

      done null, res

    return async.result


CollectionBehaviours.define 'files', (data) ->
  collections[@collection._name] =
    dir: data.dir
    url: data.url
    stores: data.stores
  if data.url.indexOf('//') is -1
    WebApp.connectHandlers.use data.url, (req, res, next) ->
      filename = req.originalUrl.replace data.url, data.dir
      img = fs.readFile filename, (err, binary) ->
        if err
          res.writeHead(404)
        else
          res.writeHead 200, 'Content-Type': 'image/jpeg'
          res.end binary, 'binary'
