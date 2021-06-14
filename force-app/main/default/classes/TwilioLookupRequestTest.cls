@isTest
private class TwilioLookupRequestTest {

    /**
     * Global Variables
     */
    static final String TEST_PHONE_NUMBER = '+15555555555';

    @isTest
    static void testEmpty() {
        TwilioLookupRequest request;
        
        Test.startTest();
            request = new TwilioLookupRequest();
        Test.stopTest();

        System.assertNotEquals(null, request, 'We expect the object to not be null.');
    }

    @isTest
    static void testPhoneNumber() {
        TwilioLookupRequest request;
        
        Test.startTest();
            request = new TwilioLookupRequest(TEST_PHONE_NUMBER);
        Test.stopTest();

        System.assertEquals(TEST_PHONE_NUMBER, request.phoneNumber, 'We expect the phone number to match.');
    }

    @isTest
    static void testFullParams() {
        String countryCode = 'US';
        Boolean getCarrier = true;
        Boolean getCallerName = false;

        TwilioLookupRequest request;
        
        Test.startTest();
            request = new TwilioLookupRequest(TEST_PHONE_NUMBER, countryCode, getCarrier, getCallerName);
        Test.stopTest();

        System.assertEquals(TEST_PHONE_NUMBER, request.phoneNumber, 'We expect the phone number to match.');
        System.assertEquals(countryCode, request.countryCode, 'We expect the country code to match.');
        System.assertEquals(getCarrier, request.getCarrier, 'We expect the `getCarrier` to match.');
        System.assertEquals(getCallerName, request.getCallerName, 'We expect `getCallerName` to match.');
    }
}
