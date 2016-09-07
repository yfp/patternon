patternon = require '../lib/patternon'

module.exports.basic = (test) ->
  test.expect 6
  pattern = patternon [
    [/hel+o/, 1]
    ['bye',  2]
    [/bye/,  3]
  ]
  test.equal 1, pattern.first('hello')
  test.equal 1, pattern.first('helllllo')
  test.equal 2, pattern.first('bye')
  test.equal 3, pattern.first('bye-bye')
  test.equal null, pattern.first('world')
  test.deepEqual [2,3], pattern.find('bye')
  test.done()

module.exports.wildcards = (test) ->
  test.expect 4
  pattern = patternon [
    ['alpha.*',     1]
    ['*.beta',      2]
    ['al??a.beta',  3]
  ]
  test.equal 1, pattern.first('alpha.beta')
  test.equal 1, pattern.first('alpha.gamma')
  test.equal 2, pattern.first('gamma.beta')
  test.deepEqual [1,2,3], pattern.find('alpha.beta')
  test.done()