public with sharing class TwilioLookupResponse {
    
    @AuraEnabled @InvocableVariable(label='Country Code' description='The ISO country code for the phone number.' required=true)
	public String country_code;
    
    @AuraEnabled @InvocableVariable(label='Phone Number' description='The phone number in E.164 format, which consists of a + followed by the country code and subscriber number.' required=true)
	public String phone_number;
    
    @AuraEnabled @InvocableVariable(label='National Format' description='The phone number, in national format.' required=true)
	public String national_format;
    
    @AuraEnabled @InvocableVariable(label='URL' description='The absolute URL of the resource.' required=true)
    public String url;
    
    @AuraEnabled @InvocableVariable(label='JSON' description='The full response.' required=true)
    public String json;
    
    @AuraEnabled @InvocableVariable(label='Caller Name' description='The name of the phone number\'s owner. If null, that information was not available.' required=false)
    public TwilioLookupResponseCallerName caller_name;
    
    @AuraEnabled @InvocableVariable(label='Carrier' description='The telecom company that provides the phone number.' required=false)
	public TwilioLookupResponseCarrier carrier;
    
    // Remove due to complexity.
	// public String add_ons;
	
    @AuraEnabled @InvocableVariable(label='Error Code' description='Error Code' required=false)
    public String code;
    
    @AuraEnabled @InvocableVariable(label='Detail' description='Detail of the Error.' required=false)
    public String detail;
    
    @AuraEnabled @InvocableVariable(label='Message' description='Error Message.' required=false)
    public String message;
    
    @AuraEnabled @InvocableVariable(label='More Info' description='Error\'s More Info.' required=false)
    public String more_info;
    
    @AuraEnabled @InvocableVariable(label='Status' description='Status of the request.' required=false)
    public String status;

	public static TwilioLookupResponse parse(String json) {
		TwilioLookupResponse result = (TwilioLookupResponse) System.JSON.deserialize(json, TwilioLookupResponse.class);
        result.json = json;
        return result;
	}
}