###*
@namespace scoping into the hquery namespace
###
this.hQuery ||= {}

# =require core.coffee

###*
@class
@augments hQuery.CodedEntry
@exports AdverseEvent as hQuery.AdverseEvent
QDM 5.0 addition.
###
class hQuery.AdverseEvent  extends hQuery.CodedEntry
  constructor: (@json) ->
    super(@json)
    # TODO: (LDY 9/29/16) Encounter includes a facility object, but we only care about location. Should we be mimicking encounter here?
    @_facility = new hQuery.Facility @json['facility'] if @json['facility']

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

  # ###*
  # The particular location of a facility in which the diagnostic study or encounter occurs or occurred. Examples include, but are not limited
  # to, intensive care units (ICUs), non-ICUs, burn critical-care unit, neonatal ICU, and respiratory-care unit.
  # @returns {String}
  # ###
  # facilityLocation: -> @json['facilityLocation']
  # 

  ###*
  @returns {hQuery.Organization}
  ###
  # TODO: (LDY: 9/29/2016) should we be mimicking encounter here to represent the facility?
  facility: -> @_facility
