@isTest
private class TwilioLookupResponseTest {

    @isTest
    static void testParse() {
        String json = '{"caller_name":{"caller_name":"WIRELESS CALLER","caller_type":null,"error_code":null},"country_code":"US","phone_number":"+15108675310","national_format":"(510) 867-5310","carrier":{"error_code":null,"mobile_country_code":"311","mobile_network_code":"880","name":"Sprint Spectrum, L.P.","type":"mobile"},"add_ons":null,"url":"https://lookups.twilio.com/v1/PhoneNumbers/+15108675310?Type=carrier&Type=caller-name"}';
        TwilioLookupResponse response;

        Test.startTest();
            response = TwilioLookupResponse.parse(json);
        Test.stopTest();

        System.assertNotEquals(null, response, 'We expect the response to be not null.');
        System.assertEquals('US', response.country_code, 'We expect the `country_code` to be `US`.');
    }
}
