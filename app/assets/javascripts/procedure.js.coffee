###*
@namespace scoping into the hquery namespace
###
this.hQuery ||= {}


# =require core.coffee
###*
This represents all interventional, surgical, diagnostic, or therapeutic procedures or 
treatments pertinent to the patient.
@class
@augments hQuery.CodedEntry
@exports Procedure as hQuery.Procedure 
###
class hQuery.Procedure extends hQuery.CodedEntry
  constructor: (@json) ->
    super(@json)
    @_facility = new hQuery.Facility @json['facility'] if @json['facility']
  

  facility: -> @_facility
  facilityArrival: -> @_facility?.startDate()
  facilityDeparture: -> @_facility?.endDate()
  ###*
  @returns {hQuery.Actor} The provider that performed the procedure
  ###
  performer: -> new hQuery.Actor @json['performer'] if @json['performer']
  
  ###*
  @returns {hQuery.CodedValue} A SNOMED code indicating the body site on which the 
  procedure was performed
  ###
  site: -> new hQuery.CodedValue @json['site']?['code'], @json['site']?['code_system']

  ###*
  @returns {hQuery.CodedValue} A SNOMED code indicating where the procedure was performed.
  ###
  source: -> 
    hQuery.createCodedValue @json['source']

  ###*
  @returns {Date} The actual or intended start of an incision.
  ###
  incisionTime: -> hQuery.dateFromUtcSeconds @json['incisionTime'] if @json['incisionTime']

  ###*
  Ordinality
  @returns {CodedValue}
  ###
  ordinality: -> hQuery.createCodedValue @json['ordinality']

  ###*
  @returns {hQuery.CodedValue} A code indicating the approach body site on which the 
  procedure was performed
  ###
  anatomical_approach: -> new hQuery.CodedValue @json['anatomical_approach']?['code'], @json['anatomical_approach']?['code_system']

  ###*
  @returns {hQuery.CodedValue} A  code indicating the body site on which the 
  procedure was performed
  ###
  anatomical_target: ->
    #backwards compatibility with older patient records.  site was used for anatomical_target
    at = @json['anatomical_target']
    if at? then new hQuery.CodedValue(at['code'], at['code_system']) else @site()
 
  ###*
  @returns {CodedValue}
  ###
  method: ->  new hQuery.createCodedValue @json['method']
 
  ###*
  @returns {CodedValue}
  ###
  reaction: ->  new hQuery.createCodedValue @json['reaction']

  ###*
  @returns {CodedValue}
  ###
  radiation_dose: ->  new hQuery.createCodedValue @json['radiation_dose']

  ###*
  @returns {CodedValue}
  ###
  radiation_duration: ->  new hQuery.createCodedValue @json['radiation_duration']
