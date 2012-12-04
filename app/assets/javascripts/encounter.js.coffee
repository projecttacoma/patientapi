###*
@namespace scoping into the hquery namespace
###
this.hQuery ||= {}


# =require core.coffee
	
###*
An Encounter is an interaction, regardless of the setting, between a patient and a
practitioner who is vested with primary responsibility for diagnosing, evaluating,
or treating the patient condition. It may include visits, appointments, as well
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
  admitType: -> new hQuery.CodedValue @json['admitType']['code'], @json['admitType']['codeSystem']
  
  ###*
  @returns {hQuery.Actor}
  ###
  performer: -> new hQuery.Actor @json['performer']
  
  ###*
  @returns {hQuery.Organization}
  ###
  facility: -> new hQuery.Facility @json['facility']

  ###*
  @returns {hQuery.CodedEntry}
  ###
  reasonForVisit: -> new hQuery.CodedEntry @json['reason']
  
  ###*
  @returns {Integer}
  ###
  lengthOfStay: ->
    return 0 unless @startDate()? && @endDate()?
    Math.floor((@endDate() - @startDate()) / (1000 * 60 * 60 * 24))

  ###*
  @returns {CodedValue}
  ###
  transferTo: -> 
    if @json['transferTo'] && @json['transferTo']['code'] && @json['transferTo']['codeSystem']
      new hQuery.CodedValue @json['transferTo']['code'], @json['transferTo']['codeSystem']
    else
      null
  
  ###*
  @returns {CodedValue}
  ###
  transferFrom: -> 
    if @json['transferFrom'] && @json['transferFrom']['code'] && @json['transferFrom']['codeSystem']
      new hQuery.CodedValue @json['transferFrom']['code'], @json['transferFrom']['codeSystem']
    else
      null  
