
upload = (file, name, cb) ->
  reader = new FileReader
  reader.onload = =>
    Meteor.call '__file__upload__', file.name, reader.result, name, (err, res) =>
      console.log res
      cb err, res

        # doc[data.field] = original: res.original
        # if data.stores?
        #   for store of data.stores
        #     doc[data.field][store] = res[store]
        # @collection._insert doc, cb

  reader.readAsBinaryString file

CollectionBehaviours.define 'files', (data) ->

  @collection._insert = @collection.insert
  @collection.insert = (doc, cb) =>
    if doc[data.field]?
      file = doc[data.field]
      upload file, @collection._name, (err, res) =>
        if err then return cb err
        doc[data.field] = res
        @collection._insert doc, cb

  @collection._update = @collection.update
  @collection.update = (selector, modifer, callback) =>
    if modifer.$set? and modifer.$set[data.field]?
      file = modifer.$set[data.field]
      upload file, @collection._name, (err, res) =>
        if err then return cb err
        modifer.$set[data.field] = res
        @collection._update selector, modifer, callback
      # reader = new FileReader
      # reader.onload = =>
      #   Meteor.call '__file__upload__', file.name, reader.result, @collection._name, (err, res) =>
      #     unless err
      #       modifer.$set[data.field] = original: res.original
      #       if data.stores?
      #         for store of data.stores
      #           modifer.$set[data.field][store] = res[store]
      #       @collection._update selector, modifer, callback
      # reader.readAsBinaryString file
