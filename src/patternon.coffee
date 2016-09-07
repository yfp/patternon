makeRegexp = (str, wildcard = yes) ->
  escaped = if wildcard
    str.replace /[\-\[\]\/\{\}\(\)\+\.\\\^\$\|]/g, "\\$&"
       .replace /\*/g, '[a-z-A-Z0-9_-]*'
       .replace /\?/g, '[a-z-A-Z0-9_-]'
  else
    str.replace /[\-\[\]\/\{\}\(\)\*\+\?\.\\\^\$\|]/g, "\\$&"
  RegExp "^#{escaped}$"

class Patternon
  constructor: (array, options)  ->
    @options = {
      wildcard: options?.wildcard or on
    }
    @rules = []
    for item in array
      @addRule item...
  addRule: (rule, value)->
    newrule = switch
      when rule instanceof RegExp then rule
      when typeof(rule) == 'string'
        makeRegexp rule, @options.wildcard
      else throw "Unknown pattern type"
    @rules.push [newrule, value]
  first: (str) ->
    for item in @rules
      if str.match item[0]
        return item[1]
    return null
  find: (str) ->
    @rules.filter ([rule, value])->
      str.match rule
    .map ([rule, value]) -> value

module.exports = (array, options) ->
  new Patternon array, options