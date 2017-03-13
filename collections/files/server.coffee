import _ from 'lodash'
import Fiber from 'fibers'
import fs from 'fs'
import fse from 'fs-extra'

collections = {}

Meteor.methods
  "__file__upload__": (name, data, collection) ->
    async = Async.runSync (done) ->
      dir = collections[collection].dir
      url = collections[collection].url
      id = Random.id()
      dir = dir + '/' + id
      url = url + '/' + id
      ext = name.split('.')
      ext = ext[ext.length-1]
      name = "original.#{ext}"
      fse.mkdirs dir, (err, res) ->
        fs.writeFile "#{dir}/#{name}", data, "binary", (err, res) ->
          done null, original: "#{url}/#{name}"

    return async.result


CollectionBehaviours.define 'files', (data) ->
  collections[@collection._name] =
    dir: data.dir
    url: data.url
  WebApp.connectHandlers.use data.url, (req, res, next) ->
    img = fs.readFileSync req.originalUrl.replace data.url, data.dir
    res.writeHead 200, 'Content-Type': 'image/jpeg'
    res.end img, 'binary'
