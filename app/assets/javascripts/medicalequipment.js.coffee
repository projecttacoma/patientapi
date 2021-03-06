###*
@namespace scoping into the hquery namespace
###
this.hQuery ||= {}

# =require core.coffee

###*

The Medical Equipment section contains information describing a patients implanted and external medical devices and equipment that their health status depends on, as well as any pertinent equipment or device history.

The template identifier for this section is 2.16.840.1.113883.3.88.11.83.128

C83-[CT-128-1] This section shall conform to the HL7 CCD section, and shall contain a templateId element whose root attribute is 2.16.840.1.113883.10.20.1.7.
C83-[CT-128-2] This section SHALL conform to the IHE Medical Devices Section, and shall contain a templateId element whose root attribute is 1.3.6.1.4.1.19376.1.5.3.1.1.5.3.5

@exports MedicalEquipment as hQuery.MedicalEquipment
@augments hQuery.CodedEntry
###
class hQuery.MedicalEquipment extends hQuery.CodedEntry

  constructor: (@json) ->
    super(@json)

  ###*
  @returns {CodedValue}
  ###
  anatomicalStructure: -> hQuery.createCodedValue @json['anatomicalStructure']

  ###*
  @returns {CodedValue}
  ###
  anatomicalApproach: -> new hQuery.createCodedValue @json['anatomicalApproach']

  ###*
  @returns {CodedValue}
  ###
  anatomicalLocation: ->
    #backwards compatibility with older patient records.  anatomicalStructure was used for anatomicalLocation
    at = @json['anatomicalLocation']
    if at? then new hQuery.CodedValue(at) else @anatomicalStructure()

  ###*
  @returns {CodedValue}
  ###
  method: ->  new hQuery.createCodedValue @json['method']

  ###*
  @returns {CodedValue}
  ###
  reaction: ->  new hQuery.createCodedValue @json['reaction']

  ###*
  @returns {Date} The actual or intended removal time of the device.
  ###
  removalTime: -> hQuery.dateFromUtcSeconds @json['removalTime'] if @json['removalTime']
