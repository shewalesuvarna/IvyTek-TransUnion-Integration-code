@isTest
global class Test_callTransUnionCRAction {
    
    @isTest
    static void testSoapCallout_Success() {
        // Test data
        List<String> CreditOutput = new List<String>{'SSNNumber%%%123456789',
                                                     'FirstName%%%John',
                                                     'LastName%%%Doe',
                                                     'Apartmentnumber%%%Apt 123',
                                                     'Street%%%Main St',
                                                     'City%%%Springfield',
                                                     'State%%%IL',
                                                     'PostalCode%%%12345',
                                                     'RecordId%%%003an000001LvIrAAK'};

      
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        Test.startTest();
        List<String> result = callTransUnionCRAction.callTransUnionCR(CreditOutput);
        Test.stopTest();
        System.assertEquals(1, result.size(), 'Expected only one result');
    }
    
    @isTest
    static void testSoapCallout_Error() {
        // Test data
        List<String> CreditOutput = new List<String>{'SSNNumber%%%123456789',
                                                     'FirstName%%%John',
                                                     'LastName%%%Doe',
                                                     'Apartmentnumber%%%Apt 123',
                                                     'Street%%%Main St',
                                                     'City%%%Springfield',
                                                     'State%%%IL',
                                                     'PostalCode%%%12345',
                                                     'RecordId%%%003an000001LvIrAAK'};

      
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGeneratorError());
        Test.startTest();
        List<String> result = callTransUnionCRAction.callTransUnionCR(CreditOutput);
        Test.stopTest();
        System.assertNotEquals(null, result, 'Error should be returned');
    } 
    // Mock HTTP response generator for success
    public class MockHttpResponseGenerator implements HttpCalloutMock {
        public HTTPResponse respond(HTTPRequest req) {
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'text/xml');
            res.setBody('<response><fileHitIndicator>regularHit</fileHitIndicator><fileHitIndicator>regularnohit</fileHitIndicator><address>hinjewadi</address><results>+750</results><transactionTimeStamp>2024-04-05T12:00:00Z</transactionTimeStamp><embeddedData>fake embedded data</embeddedData><error>null</error><description>Error message</description></response>');
            res.setStatusCode(200);
            return res;
        }
    }

    // Mock HTTP response generator for error
    public class MockHttpResponseGeneratorError implements HttpCalloutMock {
        public HTTPResponse respond(HTTPRequest req) {
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'text/xml');
            res.setBody('<error><description>Error occurred</description></error>');
            res.setStatusCode(500);
            res.setStatus('500 Internal Server Error'); 
            return res;
        }
    }
}