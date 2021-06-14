public with sharing class TwilioLookupResponseCallerName {
    @AuraEnabled @InvocableVariable(label='Caller Name' description='String indicating the name of the owner of the phone number. If not available, this will return null.' required=false)
    public String caller_name;
    
    @AuraEnabled @InvocableVariable(label='Caller Type' description='String indicating whether this caller is a business or consumer. Possible values are business, consumer. If not available, this will return null.' required=false)
    public String caller_type;
    
    @AuraEnabled @InvocableVariable(label='Caller Type' description='The error code, if any, associated with your request.' required=false)
    public String error_code;
}