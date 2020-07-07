global class AnimalsCalloutMock implements HttpCalloutMock {
    
    private String reqbody;
    private Integer statuscode;
    
    public AnimalsCalloutMock(String reqbody, Integer statuscode){
        this.reqbody = reqbody;
        this.statuscode = statuscode;
    }
    
    global HTTPResponse respond(HTTPRequest req){
        
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody(reqbody);
        res.setStatusCode(statuscode);
        return res;

    }

}