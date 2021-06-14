/**
 * This is class allows users to use Twilio Lookup.
 */
public with sharing class TwilioLookupServices {
    
    private static final String TWILIO_LOOKUP_NAMED_CREDENTIAL = 'Twilio_Lookup';
    
    @TestVisible
    private static final String COUNTRY_CODE_URL_PARAM = 'CountryCode=';
    
    @TestVisible
    private static final String GET_CARRIER_URL_PARAM = 'Type=carrier';
    
    @TestVisible
    private static final String GET_CALLER_NAME_URL_PARAM = 'Type=caller-name';
    
    @InvocableMethod(label='Lookup' description='Perfom Twilio Lookup against phone numbers.' category='Twilio')
    public static List<TwilioLookupResponse> lookup(List<TwilioLookupRequest> requests) {
        List<TwilioLookupResponse> responses = new List<TwilioLookupResponse>();
        
        for(TwilioLookupRequest aRequest : requests) {
            TwilioLookupResponse aResponse = lookup(aRequest);
            responses.add(aResponse);
        }
        
        return responses;
    }
    
    public static TwilioLookupResponse lookup(TwilioLookupRequest aRequest) {
        String phoneNumber = aRequest.phoneNumber;
        String countryCode = aRequest.countryCode;
        Boolean getCarrier = aRequest.getCarrier;
        Boolean getCallerName = aRequest.getCallerName;
        return lookup(
            phoneNumber,
            countryCode,
            getCarrier,
            getCallerName
        );
    }
    
    /**
     * Using Twilio Lookup to lookup information on a phone number.
     * @param phoneNumber The phone number to lookup in E.164 format, which consists of a + followed by the country code and subscriber number.
     * @param countryCode Optional - The ISO country code of the phone number to fetch. This is used to specify the country when the phone number is provided in a national format.
     * @param getCarrier Optional - Carrier information costs $0.005 per phone number looked up. 
     * @param getCallerName Optional - Caller Name information is currently available only in the US and costs $0.01 per phone number looked up.
     * @return TwilioLookupResponse
     **/
    @TestVisible
    private static TwilioLookupResponse lookup(String phoneNumber, String countryCode, Boolean getCarrier, Boolean getCallerName) {
        String uri = generateURI(phoneNumber, countryCode, getCarrier, getCallerName);
        
        HttpRequest req = new HttpRequest();
        req.setEndpoint(uri);
        req.setMethod('GET');
        Http http = new Http();
        HTTPResponse res = http.send(req);
        
        TwilioLookupResponse result = TwilioLookupResponse.parse(res.getBody());
        return result;
    }
    
    @TestVisible
    private static String generateURI(String phoneNumber, String countryCode, Boolean getCarrier, Boolean getCallerName) {
        String baseURI = Test.isRunningTest() ? 'http://callout.' + TWILIO_LOOKUP_NAMED_CREDENTIAL : 'callout:Twilio_Lookup';
        
        String uri = baseURI + '/v1/PhoneNumbers/' + EncodingUtil.urlEncode(phoneNumber,'UTF-8');
        
        List<String> urlParams = new List<String>();
        
        if(String.isNotBlank(countryCode)) {
            urlParams.add(COUNTRY_CODE_URL_PARAM + countryCode);
        }
        
        if(getCarrier) {
            urlParams.add(GET_CARRIER_URL_PARAM);
        }
        
        if(getCallerName) {
           	urlParams.add(GET_CALLER_NAME_URL_PARAM);
        }
        
        if(!urlParams.isEmpty()) {
            uri = uri + '?' + String.join(urlParams, '&');
        }
        
        return uri;
    }
}