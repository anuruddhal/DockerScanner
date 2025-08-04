import ballerina/http;

service /ip on new http:Listener(8080) {

    resource function get location(string ip) returns json|error {
        http:Client ipApiClient = check new ("http://ip-api.com/json/");
        json response = check ipApiClient->get("/" + ip);
        return response;
    }
}
