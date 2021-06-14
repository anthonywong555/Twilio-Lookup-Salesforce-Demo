@isTest
private class TwilioLookupServicesTest {

    /**
     * Global Variables
     */
    static final String TEST_PHONE_NUMBER = '+15108675310';
    static final String TEST_COUNTRY_CODE = 'US';
    static final String DEFAULT_LOOKUP_RESULT = '{"caller_name":null,"country_code":"US","phone_number":"+15108675310","national_format":"(510) 867-5310","carrier":null,"add_ons":null,"url":"https://lookups.twilio.com/v1/PhoneNumbers/+15108675310"}';
    static final String DEFAULT_LOOKUP_RESULT_WITH_CARRIER = '{"caller_name":null,"country_code":"US","phone_number":"+15108675310","national_format":"(510) 867-5310","carrier":{"error_code":null,"mobile_country_code":"311","mobile_network_code":"880","name":"Sprint Spectrum, L.P.","type":"mobile"},"add_ons":null,"url":"https://lookups.twilio.com/v1/PhoneNumbers/+15108675310?Type=carrier"}';
    static final String DEFAULT_LOOKUP_RESULT_WITH_CALLER_NAME = '{"caller_name":{"caller_name":"WIRELESS CALLER","caller_type":null,"error_code":null},"country_code":"US","phone_number":"+15108675310","national_format":"(510) 867-5310","carrier":null,"add_ons":null,"url":"https://lookups.twilio.com/v1/PhoneNumbers/+15108675310?Type=caller-name"}';
    static final String DEFAULT_LOOKUP_RESULT_WITH_CARRIER_AND_CALLER_NAME = '{"caller_name":{"caller_name":"WIRELESS CALLER","caller_type":null,"error_code":null},"country_code":"US","phone_number":"+15108675310","national_format":"(510) 867-5310","carrier":{"error_code":null,"mobile_country_code":"311","mobile_network_code":"880","name":"Sprint Spectrum, L.P.","type":"mobile"},"add_ons":null,"url":"https://lookups.twilio.com/v1/PhoneNumbers/+15108675310?Type=carrier&Type=caller-name"}';
    
	private class TwilioLookupHttpResponseGenerator implements HttpCalloutMock {
        
        public HTTPResponse respond(HTTPRequest req) {
            String uri = req.getEndpoint();
            String countryCode = TEST_COUNTRY_CODE;
            Boolean getCarrier = uri.contains(TwilioLookupServices.GET_CARRIER_URL_PARAM);
            Boolean getCallerName = uri.contains(TwilioLookupServices.GET_CALLER_NAME_URL_PARAM);
            
            String expectedURI = TwilioLookupServices.generateURI(
                TEST_PHONE_NUMBER, 
                countryCode, 
                getCarrier, 
                getCallerName
            );
            
            System.assertEquals(expectedURI, uri);
        	System.assertEquals('GET', req.getMethod());
            
            String body = DEFAULT_LOOKUP_RESULT;
            
            if(getCarrier && getCallerName) {
                body = DEFAULT_LOOKUP_RESULT_WITH_CARRIER_AND_CALLER_NAME;
            } else if(getCarrier) {
                body = DEFAULT_LOOKUP_RESULT_WITH_CARRIER;
            } else if(getCallerName) {
                body = DEFAULT_LOOKUP_RESULT_WITH_CALLER_NAME;
            } else {
				body = DEFAULT_LOOKUP_RESULT;
            }
            
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'application/json');
            res.setBody(body);
            res.setStatusCode(200);
            return res;
        }
	}
    
    static void setup() {
        // Setup Mock
         Test.setMock(HttpCalloutMock.class, new TwilioLookupHttpResponseGenerator());
    }
    
    @isTest
    static void testLookup() {
        setup();
        TwilioLookupResponse response;
       
        Test.startTest();
        	response = TwilioLookupServices.lookup(TEST_PHONE_NUMBER, TEST_COUNTRY_CODE, true, true);
        Test.stopTest();
        
        System.assertEquals(DEFAULT_LOOKUP_RESULT_WITH_CARRIER_AND_CALLER_NAME, response.json);
    }

	@isTest
    static void testLookupWithRequest() {
        setup();
        TwilioLookupResponse response;
        
        TwilioLookupRequest request = new TwilioLookupRequest(
            TEST_PHONE_NUMBER,
            TEST_COUNTRY_CODE,
            true,
            true
        );
        
        Test.startTest();
        	response = TwilioLookupServices.lookup(request);
        Test.stopTest();
        
        System.assertEquals(DEFAULT_LOOKUP_RESULT_WITH_CARRIER_AND_CALLER_NAME, response.json);
    }
    
    @isTest
    static void testLookupWithListOfRequest() {
        setup();
        List<TwilioLookupResponse> responses;
        
        TwilioLookupRequest request = new TwilioLookupRequest(
            TEST_PHONE_NUMBER,
            TEST_COUNTRY_CODE,
            true,
            true
        );
        
        List<TwilioLookupRequest> requests = new List<TwilioLookupRequest>();
        requests.add(request);
       
        Test.startTest();
        	responses = TwilioLookupServices.lookup(requests);
        Test.stopTest();
        
        System.assertEquals(requests.size(), responses.size());
        System.assertEquals(DEFAULT_LOOKUP_RESULT_WITH_CARRIER_AND_CALLER_NAME, responses[0].json);
    }
    
}