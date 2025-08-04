import ballerina/http;

service / on new http:Listener(8080) {

    resource function get gender(string name) returns json|error {
        http:Client ipApiClient = check new ("https://api.genderize.io/", httpVersion = http:HTTP_1_1);
        json response = check ipApiClient->get("?name=" + name);
        return response;
    }
}
