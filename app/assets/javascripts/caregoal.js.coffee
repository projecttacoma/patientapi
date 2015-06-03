###*
@namespace scoping into the hquery namespace
###
this.hQuery ||= {}

# =require core.coffee

###*

The plan of care contains data defining prospective or intended orders, interventions, encounters, services, and procedures for the patient.

@exports CareGoal as hQuery.CareGoal
@augments hQuery.CodedEntry
###
class hQuery.CareGoal extends hQuery.CodedEntry

  constructor: (@json) ->
    super(@json)

  ###*
  @returns {CodedEntryList}
  ###
  relatedTo: ->  new hQuery.createCodedEntry @json['relatedTo']


  ###*
  @returns {CodedEntryList}
  ###
  targetOutcome: ->  new hQuery.createCodedEntry @json['targetOutcome']
