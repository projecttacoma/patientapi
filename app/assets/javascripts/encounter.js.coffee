###*
@namespace scoping into the hquery namespace
###
this.hQuery ||= {}


# =require core.coffee
	
###*
An Encounter is an interaction, regardless of the setting, between a patient and a
practitioner who is vested with primary responsibility for diagnosing, evaluating,
or treating the patients condition. It may include visits, appointments, as well
as non face-to-face interactions. It is also a contact between a patient and a
practitioner who has primary responsibility for assessing and treating the
patient at a given contact, exercising independent judgment.
@class An Encounter is an interaction, regardless of the setting, between a patient and a
practitioner
@augments hQuery.CodedEntry
@exports Encounter as hQuery.Encounter 
###
class hQuery.Encounter extends hQuery.CodedEntry
  constructor: (@json) ->
    super(@json)
  	
  ###*
  @returns {String}
  ####
  dischargeDisposition: -> @json['dischargeDisposition']
  
  ###*
  A code indicating the priority of the admission (e.g., Emergency, Urgent, Elective, et cetera) from
  National Uniform Billing Committee (NUBC)
  @returns {CodedValue}
  ###
  admitType: -> hQuery.createCodedValue @json['admitType']
  
  ###*
  @returns {hQuery.Actor}
  ###
  performer: -> new hQuery.Actor @json['performer']
  
  ###*
  @returns {hQuery.Organization}
  ###
  facility: -> new hQuery.Facility @json['facility']

  ###*
  @returns {hQuery.DateRange}
  ###
  encounterDuration: -> new hQuery.DateRange @json
  
  ###*
  @returns {hQuery.CodedEntry}
  ###
  reasonForVisit: -> new hQuery.CodedEntry @json['reason']
  
  ###*
  @returns {Integer}
  ###
  lengthOfStay: ->
    return 0 unless @json['hi']? && @json['low']?
    Math.floor((@json['hi'] - @json['low']) / (60 * 60 * 24))

  ###*
  @returns {CodedValue}
  ###
  transferTo: -> hQuery.createCodedValue @json['transferTo']
  
  ###*
  @returns {CodedValue}
  ###
  transferFrom: -> hQuery.createCodedValue @json['transferFrom']
