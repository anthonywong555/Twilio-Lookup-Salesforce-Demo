public with sharing class TwilioLookupRequest {
	@InvocableVariable(label='Phone Number' description='The phone number to lookup in E.164 format, which consists of a + followed by the country code and subscriber number.' required=true)
    public String phoneNumber;
    
    @InvocableVariable(label='Country Code' description='The ISO country code of the phone number to fetch. This is used to specify the country when the phone number is provided in a national format.' required=false)
    public String countryCode;
    
    @InvocableVariable(label='Carrier' description='Carrier information costs $0.005 per phone number looked up.' required=false)
    public Boolean getCarrier;
    
    @InvocableVariable(label='Caller Name' description='Caller Name information is currently available only in the US and costs $0.01 per phone number looked up.' required=false)
    public Boolean getCallerName;
    
    public TwilioLookupRequest() {}

    public TwilioLookupRequest(String phoneNumber) {
        this.phoneNumber = phoneNumber;
        this.countryCode = null;
        this.getCarrier = false;
        this.getCallerName = false;
    }
    
    public TwilioLookupRequest(String phoneNumber, String countryCode, Boolean getCarrier, Boolean getCallerName) {
        this.phoneNumber = phoneNumber;
        this.countryCode = countryCode;
        this.getCarrier = getCarrier;
        this.getCallerName = getCallerName;
    }
}