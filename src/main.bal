import ballerina/auth as _;
import ballerina/cache as _;
import ballerina/constraint as _;
import ballerina/crypto as _;
import ballerina/data.jsondata as _;
import ballerina/file as _;
import ballerina/http;
import ballerina/io as _;
import ballerina/jwt as _;
import ballerina/log as _;
import ballerina/mime as _;
import ballerina/oauth2 as _;
import ballerina/observe as _;
import ballerina/os as _;
import ballerina/sql as _;
import ballerina/task as _;
import ballerina/time as _;
import ballerina/url as _;
import ballerina/uuid as _;
import ballerinax/asb as _;
import ballerinax/cdc as _;
import ballerinax/mssql as _;
import ballerinax/mssql.driver as _;

import ballerinai/observe as _;

service / on new http:Listener(8080) {

    resource function get gender(string name) returns json|error {
        http:Client ipApiClient = check new ("https://api.genderize.io/", httpVersion = http:HTTP_1_1);
        json response = check ipApiClient->get("?name=" + name);
        return response;
    }
}

