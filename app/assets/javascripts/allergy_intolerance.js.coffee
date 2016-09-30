###*
@namespace scoping into the hquery namespace
###
this.hQuery ||= {}

# =require core.coffee

###*
@class
@augments hQuery.CodedEntry
@exports AllergyIntolerance as hQuery.AllergyIntolerance
QDM 5.0 addition. To be used in place of `allergy` for models involving QDM 5.0.
TODO: (LDY 9/29/16) It may be worth reconsidering adding a new class for this and figuring out how to reuse
plain `allergy` in a logical way.
###
class hQuery.AllergyIntolerance  extends hQuery.CodedEntry
  constructor: (@json) ->
    super(@json)

  ###*
  The characterization of the reaction (e.g., hypersensitivity, rash, gastroenteric symptoms, etc.)
  @returns {CodedValue}
  ###
  adverseEventType: -> hQuery.createCodedValue @json['type']

  ###*
  This is a description of the level of the severity of the allergy or intolerance.
  @returns {CodedValue}
  ###
  severity: -> hQuery.createCodedValue @json['severity']
