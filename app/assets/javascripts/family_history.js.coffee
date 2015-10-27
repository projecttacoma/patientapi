###*
@namespace scoping into the hquery namespace
###
this.hQuery ||= {}


# =require core.coffee
###*
This represents all  family history.
@class
@augments hQuery.CodedEntry
@exports Family_History as hQuery.Family_History
###
class hQuery.Family_History extends hQuery.CodedEntry
  constructor: (@json) ->
    super(@json)


  ###*
  @returns {CodedValue}
  ###
  relationship: ->  new hQuery.createCodedValue @json['relationshipToPatient']