import ballerina/http;

service /ip on new http:Listener(8080) {

    resource function get location(string name) returns json|error {
        http:Client ipApiClient = check new ("https://api.genderize.io/", httpVersion = http:HTTP_2_0);
        json response = check ipApiClient->get("?name=" + name);
        return response;
    }
}
