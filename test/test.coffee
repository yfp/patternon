patternon = require '../lib/patternon'

module.exports.basic = (test) ->
  test.expect 4
  pattern = patternon [
    [/hel+o/, 1]
    ['bye',  2]
    [/bye/,  3]
  ]
  console.log pattern.rules
  test.equal 1, pattern.first('hello')
  test.equal 1, pattern.first('helllllo')
  test.equal 2, pattern.first('bye')
  test.equal 3, pattern.first('bye-bye')
  test.done()
