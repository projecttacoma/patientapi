# =require core.js.coffee
# =require medication.js.coffee
# =require condition.js.coffee
# =require encounter.js.coffee
# =require procedure.js.coffee
# =require communication.js.coffee
# =require familyhistory.js.coffee
# =require result.js.coffee
# =require immunization.js.coffee
# =require allergy.js.coffee
# =require provider.js.coffee
# =require languages.js.coffee
# =require pregnancy.js.coffee
# =require socialhistory.js.coffee
# =require caregoal.js.coffee
# =require medicalequipment.js.coffee
# =require functionalstatus.js.coffee
# =require careexperience.js.coffee
# =require assessment.js.coffee
# =require adverse_event.js.coffee
# =require allergy_intolerance.js.coffee

###*
@namespace scoping into the hquery namespace
###
this.hQuery ||= {}

###*
@class Supports
@exports Supports as hQuery.Supports
###
class hQuery.Supports
  constructor: (@json) ->
  ###*
  @returns {DateRange}
  ###
  supportDate: -> new hQuery.DateRange @json['supportDate']

  ###*
  @returns {Person}
  ###
  guardian: -> new hQuery.Person @json['guardian']

  ###*
  @returns {String}
  ###
  guardianSupportType: -> @json['guardianSupportType']

  ###*
  @returns {Person}
  ###
  contact: -> new hQuery.Person @json['contact']

  ###*
  @returns {String}
  ###
  contactSupportType: -> @json['guardianSupportType']


###*
@class Representation of a patient
@augments hQuery.Person
@exports Patient as hQuery.Patient
###
class hQuery.Patient extends hQuery.Person
  ###*
  @returns {String} containing M or F representing the gender of the patient
  ###
  gender: -> @json['gender']

  ###*
  @returns {Date} containing the patients birthdate
  ###
  birthtime: ->
    hQuery.dateFromUtcSeconds @json['birthdate'] if @json['birthdate']

  ###*
  @param (Date) date the date at which the patient age is calculated, defaults to now.
  @returns {number} the patient age in years
  ###
  age: (date = new Date()) ->
    oneDay = 24*60*60*1000;
    oneYear = 365*oneDay;
    return (date.getTime()-this.birthtime().getTime())/oneYear;

  ###*
  @returns {CodedValue} the domestic partnership status of the patient
  The following HL7 codeset is used:
  A  Annulled
  D  Divorced
  I   Interlocutory
  L  Legally separated
  M  Married
  P  Polygamous
  S  Never Married
  T  Domestic Partner
  W  Widowed
  ###
  maritalStatus: ->
    if @json['maritalStatus']
      return hQuery.createCodedValue @json['maritalStatus']

  ###*
  @returns {CodedValue}  of the spiritual faith affiliation of the patient
  It uses the HL7 codeset.  http://www.hl7.org/memonly/downloads/v3edition.cfm#V32008
  ###
  religiousAffiliation: ->
    if @json['religiousAffiliation']
      return hQuery.createCodedValue @json['religiousAffiliation']

  ###*
  @returns {CodedValue}  of the race of the patient
  CDC codes:  http://phinvads.cdc.gov/vads/ViewCodeSystemConcept.action?oid=2.16.840.1.113883.6.238&code=1000-9
  ###
  race: ->
    if @json['race']
      return hQuery.createCodedValue code: @json['race'], code_system: 'CDC Race'

  ###*
  @returns {CodedValue} of the payer of the patient
  SOP codes: https://www.health.ny.gov/statistics/sparcs/sysdoc/appp.htm
  ###
  payer: ->
    if @json['insurance_providers']?.length
      ip = @json['insurance_providers'][0]
      if ip.codes && ip.codes.SOP?.length
        return hQuery.createCodedValue code: ip.codes.SOP[0], code_system: 'SOP'

  ###*
  @returns {CodedValue} of the ethnicity of the patient
  CDC codes:  http://phinvads.cdc.gov/vads/ViewCodeSystemConcept.action?oid=2.16.840.1.113883.6.238&code=1000-9
  ###
  ethnicity: ->
    if @json['ethnicity']
      return hQuery.createCodedValue code: @json['ethnicity'], code_system: 'CDC Ethnicity'

  ###*
  @returns {CodedValue} This is the code specifying the level of confidentiality of the document.
  HL7 Confidentiality Code (2.16.840.1.113883.5.25)
  ###
  confidentiality: ->
    if  @json['confidentiality']
      return hQuery.createCodedValue @json['confidentiality']

  ###*
  @returns {Address} of the location where the patient was born
  ###
  birthPlace: ->
    new hQuery.Address @json['birthPlace']

  ###*
  @returns {Supports} information regarding key support contacts relative to healthcare decisions, including next of kin
  ###
  supports: -> new hQuery.Supports @json['supports']

  ###*
  @returns {Organization}
  ###
  custodian: -> new hQuery.Organization @json['custodian']

  ###*
  @returns {Provider}  the providers associated with the patient
  ###
  provider: -> new hQuery.Provider @json['provider']


  ###*
  @returns {hQuery.CodedEntryList} A list of {@link hQuery.LanguagesSpoken} objects
  Code from http://www.ietf.org/rfc/rfc4646.txt representing the name of the human language
  ###
  languages: ->
    list = new hQuery.CodedEntryList
    if @json['languages']
      for language in @json['languages']
        list.push(new hQuery.Language(language))
    list

  ###*
  @returns {Boolean} returns true if the patient has died
  ###
  expired: -> @json['expired']

  ###*
  @returns {hQuery.CodedEntryList} A list of {@link hQuery.Encounter} objects
  ###
  encounters: ->
    list = new hQuery.CodedEntryList
    if @json['encounters']
      for encounter in @json['encounters']
        list.pushIfUsable(new hQuery.Encounter(encounter))
    list

  ###*
  @returns {hQuery.CodedEntryList} A list of {@link Medication} objects
  ###
  medications: ->
    list = new hQuery.CodedEntryList
    if @json['medications']
      for medication in @json['medications']
        list.pushIfUsable(new hQuery.Medication(medication))
    list


  ###*
  @returns {hQuery.CodedEntryList} A list of {@link Condition} objects
  ###
  conditions: ->
    list = new hQuery.CodedEntryList
    if @json['conditions']
      for condition in @json['conditions']
        list.pushIfUsable(new hQuery.Condition(condition))
    list

  ###*
  @returns {hQuery.CodedEntryList} A list of {@link Procedure} objects
  ###
  procedures: ->
    list = new hQuery.CodedEntryList
    if @json['procedures']
      for procedure in @json['procedures']
        list.pushIfUsable(new hQuery.Procedure(procedure))
    list

  ###*
  @returns {hQuery.CodedEntryList} A list of {@link Communication} objects
  ###
  communications: ->
    list = new hQuery.CodedEntryList
    if @json['communications']
      for communication in @json['communications']
        list.pushIfUsable(new hQuery.Communication(communication))
    list

  ###*
  @returns {hQuery.CodedEntryList} A list of {@link FamilyHistory} objects
  ###
  family_history: ->
    list = new hQuery.CodedEntryList
    if @json['family_history']
      for familyhistory in @json['family_history']
        list.pushIfUsable(new hQuery.FamilyHistory(familyhistory))
    list

  ###*
  @returns {hQuery.CodedEntryList} A list of {@link CareExperience} objects
  ###
  careExperiences: ->
    list = new hQuery.CodedEntryList
    if @json['care_experiences']
      for care_experience in @json['care_experiences']
        list.pushIfUsable(new hQuery.CareExperience(care_experience))
    list

  ###*
  @returns {hQuery.CodedEntryList} A list of {@link Assessment} objects
  ###
  assessments: ->
    list = new hQuery.CodedEntryList
    if @json['assessments']
      for assessment in @json['assessments']
        list.pushIfUsable(new hQuery.Assessment(assessment))
    list

  ###*
  @returns {hQuery.CodedEntryList} A list of {@link Result} objects
  ###
  results: ->
    list = new hQuery.CodedEntryList
    if @json['results']
      for result in @json['results']
        list.pushIfUsable(new hQuery.Result(result))
    list

  ###*
  @returns {hQuery.CodedEntryList} A list of {@link Result} objects
  ###
  vitalSigns: ->
    list = new hQuery.CodedEntryList
    if @json['vital_signs']
      for vital in @json['vital_signs']
        list.pushIfUsable(new hQuery.Result(vital))
    list

  ###*
  @returns {hQuery.CodedEntryList} A list of {@link Immunization} objects
  ###
  immunizations: ->
    list = new hQuery.CodedEntryList
    if @json['immunizations']
      for immunization in @json['immunizations']
        list.pushIfUsable(new hQuery.Immunization(immunization))
    list


  ###*
  @returns {hQuery.CodedEntryList} A list of {@link Allergy} objects
  ###
  allergies: ->
    list = new hQuery.CodedEntryList
    if @json['allergies']
      for allergy in @json['allergies']
        list.pushIfUsable(new hQuery.Allergy(allergy))
    list

  ###*
  @returns {hQuery.CodedEntryList} A list of {@link Pregnancy} objects
  ###
  pregnancies: ->
    list = new hQuery.CodedEntryList
    if @json['pregnancies']
      for pregnancy in @json['pregnancies']
        list.pushIfUsable(new hQuery.Pregnancy(pregnancy))
    list

  ###*
  @returns {hQuery.CodedEntryList} A list of {@link Socialhistory} objects
  ###
  socialHistories: ->
    list = new hQuery.CodedEntryList
    if @json['socialhistories']
      for socialhistory in @json['socialhistories']
        list.pushIfUsable(new hQuery.Socialhistory(socialhistory))
    list

  ###*
  @returns {hQuery.CodedEntryList} A list of {@link CareGoal} objects
  ###
  careGoals: ->
    list = new hQuery.CodedEntryList
    if @json['care_goals']
      for caregoal in @json['care_goals']
        list.pushIfUsable(new hQuery.CareGoal(caregoal))
    list

  ###*
  @returns {hQuery.CodedEntryList} A list of {@link MedicalEquipment} objects
  ###
  medicalEquipment: ->
    list = new hQuery.CodedEntryList
    if @json['medical_equipment']
      for equipment in @json['medical_equipment']
        list.pushIfUsable(new hQuery.MedicalEquipment(equipment))
    list

  ###*
  @returns {hQuery.CodedEntryList} A list of {@link FunctionalStatus} objects
  ###
  functionalStatuses: ->
    list = new hQuery.CodedEntryList
    if @json['functional_statuses']
      for fs in @json['functional_statuses']
        list.pushIfUsable(new hQuery.FunctionalStatus(fs))
    list

  ###*
  @returns {hQuery.CodedEntryList} A list of {@link AllergyIntolerance} objects
  ###
  allergiesIntolerances: ->
    list = new hQuery.CodedEntryList
    if @json['allergies_intolerances']
      for allergy_intolerance in @json['allergies_intolerances']
        list.pushIfUsable(new hQuery.AllergyIntolerance(allergy_intolerance))
    list

  ###*
  @returns {hQuery.CodedEntryList} A list of {@link AdverseEvent} objects
  ###
  adverseEvents: ->
    list = new hQuery.CodedEntryList
    if @json['adverse_events']
      for adverse_event in @json['adverse_events']
        list.pushIfUsable(new hQuery.AdverseEvent(adverse_event))
    list
