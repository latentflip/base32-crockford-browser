vows = require 'vows'
assert = require 'assert'
base32 = require '../lib/base32.js'
crypto = require 'crypto'

suite = vows.describe 'Base32 Encoding'

teststring = 'lowercase UPPERCASE 1234567 !@#$%^&*'

suite = suite.addBatch
  'When encoding a test string':
    topic: ->
      base32.encode teststring

    'it has the right value': (topic) ->
      assert.equal topic, 'dhqqetbjcdgq6t90an850haj8d0n6h9064t36d1n6rvj08a04cj2aqh658'

    'it decodes to the right value': (topic) ->
      assert.equal base32.decode(topic), teststring

  'When encoding a sha1 sum':
    topic: ->
      sha1 = crypto.createHash('sha1').update(teststring).digest('binary')
      original: sha1, encoded: base32.encode sha1

    'it has the right value': (topic) ->
      assert.equal topic.encoded, '1wwn60g9bv8n5g8n72udmk7yqm80dvtu'

    'it has 32 characters': (topic) ->
      assert.equal topic.encoded.length, 32

    'it decodes correctly': (topic) ->
      assert.equal topic.original, base32.decode(topic.encoded)

  'When streaming a string to encode':
    topic: ->
      enc = new base32.Encoder
      output = enc.update teststring.substr(0,10)
      output+= enc.update teststring.substr(10)
      output+= enc.finish()
      output

    'it should produce the correct value': (topic) ->
      assert.equal topic, 'dhqqetbjcdgq6t90an850haj8d0n6h9064t36d1n6rvj08a04cj2aqh658'

  'When decoding a string with common errors':
    topic: ->
      base32.decode 'dHqqetbjcdgq6t9Oan850hAj8d0n6h9O64t36dLn6rvjO8a04cj2aqh6S8'

    'it should be the same as the original': (topic) ->
      assert.equal topic, teststring

suite.run()
