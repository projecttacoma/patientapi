###*
@namespace scoping into the hquery namespace
###
this.hQuery ||= {}


# =require core.coffee
###*
This represents all care experience.
@class
@augments hQuery.CodedEntry
@exports Assessment as hQuery.Assessment
###
class hQuery.Assessment extends hQuery.CodedEntry
  constructor: (@json) ->
    super(@json)

  ###*
  @returns {CodedValue}
  ###
  method: -> hQuery.createCodedValue @json['method']
  
  ###*
  @returns {Array, hquery.Component} an array of components
  ###
  components: ->  
    for  component in @json['Components']
      new hQuery.Component component
