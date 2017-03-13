
CollectionBehaviours.define 'files', (data) ->

  @collection._insert = @collection.insert
  @collection.insert = (doc, cb) =>
    if doc[data.field]?
      file = doc[data.field]
      reader = new FileReader
      reader.onload = =>
        Meteor.call '__file__upload__', file.name, reader.result, @collection._name, (err, res) =>
          unless err
            doc[data.field] = original: res.original
            @collection._insert doc, cb

      reader.readAsBinaryString file
