regexp_from_string = (str) ->
  escaped = str.replace /[\-\[\]\/\{\}\(\)\*\+\?\.\\\^\$\|]/g, "\\$&"
  RegExp "^#{escaped}$"

class Patternon
  constructor: (array, options)  ->
    @options = {
      wildcard: options?.wildcard or on
    }
    @rules = []
    for item in array
      
      [rule, value] = item
      newrule = switch
        when rule instanceof RegExp then rule
        when typeof(rule) == 'string' then regexp_from_string rule
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