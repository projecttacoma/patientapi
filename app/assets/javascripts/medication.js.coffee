###*
@namespace scoping into the hquery namespace
###
this.hQuery ||= {}


# =require core.coffee
###*
@class MedicationInformation
@exports MedicationInformation as hQuery.MedicationInformation
###
class hQuery.MedicationInformation
  constructor: (@json) ->

  ###*
  An array of hQuery.CodedValue describing the medication
  @returns {Array}
  ####
  codedProduct: -> hQuery.createCodedValues @json['codes']
  freeTextProductName: -> @json['description']
  codedBrandName: -> @json['codedBrandName']
  freeTextBrandName: -> @json['brandName']
  drugManufacturer: ->
    if(@json['drugManufacturer'])
      new hQuery.Organization(@json['drugManufacturer'])

###*
@class AdministrationTiming - the
@exports AdministrationTiming as hQuery.AdministrationTiming
###
class hQuery.AdministrationTiming
  constructor: (@json) ->

  ###*
  Provides the period of medication administration as a Scalar. An example
  Scalar that would be returned would be with value = 8 and units = hours. This would
  mean that the medication should be taken every 8 hours.
  @returns {hQuery.Scalar}
  ###
  period: -> new hQuery.Scalar @json['period'] if @json['period']

  ###*
  Indicates whether it is the interval (time between dosing), or frequency
  (number of doses in a time period) that is important. If instititutionSpecified is not
  present or is set to false, then the time between dosing is important (every 8 hours).
  If true, then the frequency of administration is important (e.g., 3 times per day).
  @returns {Boolean}
  ###
  institutionSpecified: -> @json['institutionSpecified']

###*
@class DoseRestriction -  restrictions on the medications dose, represented by a upper and lower dose
@exports DoseRestriction as hQuery.DoseRestriction
###
class hQuery.DoseRestriction
  constructor: (@json) ->
  numerator: -> new hQuery.Scalar @json['numerator'] if @json['numerator']
  denominator: -> new hQuery.Scalar @json['denominator'] if @json['denominator']


###*
@class Fulfillment - information about when and who fulfilled an order for the medication
@exports Fulfillment as hQuery.Fullfilement
###
class hQuery.Fulfillment
  constructor: (@json) ->

  dispenseDate: -> hQuery.dateFromUtcSeconds @json['dispenseDate']
  dispensingPharmacyLocation: -> new hQuery.Address @json['dispensingPharmacyLocation'] if @json['dispensingPharmacyLocation']
  quantityDispensed: -> new hQuery.Scalar @json['quantityDispensed'] if @json['quantityDispensed']
  prescriptionNumber: -> @json['prescriptionNumber']
  fillNumber: -> @json['fillNumber']
  fillStatus: -> new hQuery.Status @json['fillStatus'] if @json['fillStatus']

###*
@class OrderInformation - information abour an order for a medication
@exports OrderInformation as hQuery.OrderInformation
###
class hQuery.OrderInformation
  constructor: (@json) ->

  orderNumber: -> @json['orderNumber']
  fills: -> @json['fills']
  quantityOrdered: -> new hQuery.Scalar @json['quantityOrdered'] if @json['quantityOrdered']
  orderExpirationDateTime: -> hQuery.dateFromUtcSeconds @json['orderExpirationDateTime']
  orderDateTime: -> hQuery.dateFromUtcSeconds @json['orderDateTime']


###*
TypeOfMedication as defined by value set 2.16.840.1.113883.3.88.12.3221.8.19
which pulls two values from SNOMED to describe whether a medication is
prescription or over the counter

@class TypeOfMedication - describes whether a medication is prescription or
       over the counter
@augments hQuery.CodedEntry
@exports TypeOfMedication as hQuery.TypeOfMedication
###
class hQuery.TypeOfMedication extends hQuery.CodedValue
  PRESECRIPTION = "73639000" # SNOMED code for preseciption medications
  OTC = "329505003" # SNOMED code for over the counter medications

  ###*
  @returns {Boolean}
  ###
  isPrescription: -> @c is PRESECRIPTION

  ###*
  @returns {Boolean}
  ###
  isOverTheCounter: -> @c is OTC


###*
StatusOfMedication as defined by value set 2.16.840.1.113883.1.11.20.7
The terms come from SNOMED and are managed by HL7

@class StatusOfMedication - describes the status of the medication
@augments hQuery.CodedEntry
@exports StatusOfMedication as hQuery.StatusOfMedication
###
class hQuery.StatusOfMedication extends hQuery.CodedValue
  ON_HOLD = "392521001"
  NO_LONGER_ACTIVE = "421139008"
  ACTIVE = "55561003"
  PRIOR_HISTORY = "73425007"

  ###*
  @returns {Boolean}
  ###
  isOnHold: -> @c is ON_HOLD

  ###*
  @returns {Boolean}
  ###
  isNoLongerActive: -> @c is NO_LONGER_ACTIVE

  ###*
  @returns {Boolean}
  ###
  isActive: -> @c is ACTIVE

  ###*
  @returns {Boolean}
  ###
  isPriorHistory: -> @c is PRIOR_HISTORY

###*
@class represents a medication entry for a patient.
@augments hQuery.CodedEntry
@exports Medication as hQuery.Medication
###
class hQuery.Medication  extends hQuery.CodedEntry
  constructor: (@json) ->
    super(@json)

  ###*
  @returns {String}
  ####
  freeTextSig: -> @json['freeTextSig']

  ###*
  The actual or intended start of a medication. Slight deviation from greenCDA for C32 since
  it combines this with medication stop
  @returns {Date}
  ###
  indicateMedicationStart: -> hQuery.dateFromUtcSeconds @json['start_time']

  ###*
  The actual or intended stop of a medication. Slight deviation from greenCDA for C32 since
  it combines this with medication start
  @returns {Date}
  ###
  indicateMedicationStop: -> hQuery.dateFromUtcSeconds @json['end_time']


  ###*
  @returns {Date}
  ###
  activeDateTime: -> hQuery.dateFromUtcSeconds @json['active_datetime']  if @json['active_datetime']

  ###*
  @returns {Date}
  ###
  signedDateTime: -> hQuery.dateFromUtcSeconds @json['signed_datetime']  if @json['signed_datetime']


  administrationTiming: -> new hQuery.AdministrationTiming @json['administrationTiming'] if @json['administrationTiming']

  ###*
  This is used for Medicaton, Order. It is the total number of times a dose of a particular
  medication can be administered. This, coupled with the administrationTiming will
  give the cumulative medication duration.
  E.g.
    allowedAdministrations = 90 doses
    administrationTiming = 1 dose / 12 hours
    cumulativeMedicationDuration = allowedAdministrations / administrationTiming * (time conversion)
    cumulativeMedicationDuration = (90 doses) * (12 hours)/(1 dose) * (1 day)/(24 hours) = 45 days
  Medication, Order can't use fulfillmentHistory because the fulfillment of the 
  medication has not yet happened.
  This corresponds to 'repeatNumber' in the QRDA representation
  @returns {Integer}
  ###
  allowedAdministrations: -> @json['allowedAdministrations']

  ###*
  @returns {CodedValue}  Contains routeCode or adminstrationUnitCode information.
    Route code shall have a a value drawn from FDA route of administration,
    and indicates how the medication is received by the patient.
    See http://www.fda.gov/Drugs/DevelopmentApprovalProcess/UCM070829
    The administration unit code shall have a value drawn from the FDA
    dosage form, source NCI thesaurus and represents the physical form of the
    product as presented to the patient.
    See http://www.fda.gov/Drugs/InformationOnDrugs/ucm142454.htm
  ###
  route: -> hQuery.createCodedValue @json['route']

  ###*
  @returns {Hash} with two keys: units and scalar
  ###
  dose: ->
    # In Bonnie, dose can be specified in two different contexts: CMD specification and as a field value; the
    # CMD version used 'unit' and 'value', while the field value version uses 'units' and 'scalar'; we want to
    # consolidate the versions, so here we convert everything to the field value style
    # in QDM 5.0, this is now 'dosage'. This is only changed in the Bonnie view.
    if @json.dose
      units: @json.dose.units || @json.dose.unit
      scalar: @json.dose.scalar || @json.dose.value

  ###*
  @returns {Hash} with two keys: units and scalar
  The quantity (amount) of therapeutic agent that was provided to a patient (i.e., number of doses, number of tablets or pills, volume of medication)
   * Used while the patient was on the given medication.
   * Actually administered to a patient.
   * Indicated to be given during a procedure, diagnostic test, or medication or substance administration.
   * Dispensed to a patient to be taken at a later time.
   * Indicated to be given to a patient.
   * Recommended to be taken or administered to a patient.
  ###
  supply: ->
    # QDM 5.0 disambiguates dose to be 'dosage' or 'supply'. For this reason, supply uses the same form as dose does.
    if @json.supply
      units: @json.supply.units || @json.supply.unit
      value: @json.supply.scalar || @json.supply.value

  ###*
  @returns {CodedValue}
  ###
  site: -> hQuery.createCodedValue @json['site'] if @json['site']

  ###*
  @returns {CodedValue}
  ###
  anatomicalApproach: ->
    #backwards compatibility for older patient records
    if @json['anatomicalApproach'] then hQuery.createCodedValue @json['anatomicalApproach'] else @site()
  ###*
  @returns {hQuery.DoseRestriction}
  ###
  doseRestriction: -> new hQuery.DoseRestriction @json['doseRestriction'] if @json['doseRestriction']

  ###*
  @returns {String}
  ###
  doseIndicator: -> @json['doseIndicator']

  ###*
  @returns {String}
  ###
  fulfillmentInstructions: -> @json['fulfillmentInstructions']

  ###*
  @returns {CodedValue}
  ###
  indication: -> hQuery.createCodedValue @json['indication']

  ###*
  @returns {CodedValue}
  ###
  productForm: -> hQuery.createCodedValue @json['productForm']

  ###*
  @returns {CodedValue}
  ###
  vehicle: -> hQuery.createCodedValue  @json['vehicle']

  ###*
  @returns {CodedValue}
  ###
  reaction: -> hQuery.createCodedValue @json['reaction']

  ###*
  @returns {CodedValue}
  ###
  deliveryMethod: -> hQuery.createCodedValue @json['deliveryMethod']

  ###*
  @returns {CodedValue}
  ###
  method: -> hQuery.createCodedValue @json['method']

  ###*
  @returns {hQuery.MedicationInformation}
  ###
  medicationInformation: -> new hQuery.MedicationInformation @json

  ###*
  @returns {hQuery.TypeOfMedication} Indicates whether this is an over the counter or prescription medication
  ###
  typeOfMedication: -> new hQuery.TypeOfMedication @json['typeOfMedication']?['code'], @json['typeOfMedication']?['code_system']

  ###*
  Values conform to value set 2.16.840.1.113883.1.11.20.7 - Medication Status
  Values may be: On Hold, No Longer Active, Active, Prior History
  @returns {hQuery.StatusOfMedication}   Used to indicate the status of the medication.
  ###
  statusOfMedication: -> new hQuery.StatusOfMedication @json['statusOfMedication']?['code'], @json['statusOfMedication']?['code_system']

  ###*
  @returns {String} free text instructions to the patient
  ###
  patientInstructions: -> @json['patientInstructions']

  ###*
  The duration over which this medication has been active. For example, 5 days.
  @returns {Hash} with two keys: unit and scalar
  ###
  cumulativeMedicationDuration: -> @json['cumulativeMedicationDuration']

  refills: -> @json['refills']
  ###*
  @returns {Array} an array of {@link FulFillment} objects
  ###
  fulfillmentHistory: ->
    for order in @json['fulfillmentHistory']
      new hQuery.Fulfillment order

  ###*
  @returns {Array} an array of {@link OrderInformation} objects
  ###
  orderInformation: ->
    for order in @json['orderInformation']
      new hQuery.OrderInformation order
