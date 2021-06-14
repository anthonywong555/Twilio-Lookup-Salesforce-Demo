public with sharing class TwilioLookupResponseCarrier {
	@AuraEnabled @InvocableVariable(label='Mobile Country Code' description='The mobile country code of the carrier (for mobile numbers only).' required=false)
    public String mobile_country_code;
    
    @AuraEnabled @InvocableVariable(label='Mobile Network Code' description='The mobile network code of the carrier (for mobile numbers only).' required=false)
    public String mobile_network_code;
    
    @AuraEnabled @InvocableVariable(label='Name' description='The name of the carrier. Please bear in mind that carriers rebrand themselves constantly and that the names used for carriers will likely change over time.' required=false)
    public String name;
    
    @AuraEnabled @InvocableVariable(label='Type' description='The phone number type. Possible values are landline, mobile, or voip. See \'Phone Number Type\' below for more information.' required=false)
    public String type;
    
    @AuraEnabled @InvocableVariable(label='Error Code' description='The error code, if any, associated with your request.' required=false)
    public String error_code;
}