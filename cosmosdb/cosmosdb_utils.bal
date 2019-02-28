// Copyright (c) 2019, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
//
// WSO2 Inc. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

import ballerina/crypto;
import ballerina/encoding;
import ballerina/http;
import ballerina/system;
import ballerina/time;

function costructRequestHeaders(http:Request request, string httpMethod, string resourceType, string resourceLink,
                        string masterKey, string contentType, RequestOptions? requestOptions = ()) returns error? {
    time:Time time = time:currentTime();
    time:Time standardTime = time:toTimeZone(time, "GMT");
    string dateString = time:format(standardTime, DATE_TIME_FORMAT);

    string stringToSign = string `{{httpMethod.toLower()}}{{NEW_LINE}}{{resourceType.toLower()}}
        {{NEW_LINE}}{{resourceLink}}{{NEW_LINE}}{{dateString.toLower()}}{{NEW_LINE}}{{EMPTY_STRING}}{{NEW_LINE}}`;
    byte[] key = check encoding:decodeBase64(masterKey);
    string signature = encoding:encodeBase64(crypto:hmacSha256(stringToSign.toByteArray("UTF-8"), key));

    string authHeaderString = check http:encode(string `type={{MASTER_TOKEN}}&ver={{TOKEN_VERSION}}&sig={{signature}}`,
        "UTF-8");
    request.setHeader(AUTHORIZATION, authHeaderString);
    request.setHeader(VERSION, X_MS_VERSION);
    request.setHeader(X_DATE, dateString);
    request.setHeader(CONTENT_TYPE, contentType);
    setOptionalHeaders(request, requestOptions = requestOptions);
    return ();
}

function setOptionalHeaders(http:Request request, RequestOptions? requestOptions = ()) {
    string? sessionToken = requestOptions["sessionToken"];
    if (sessionToken is string) {
        request.setHeader(SESSION_TOKEN, sessionToken);
    }

    string? consistencyLevel = requestOptions["consistencyLevel"];
    if (consistencyLevel is string) {
        request.setHeader(CONSISTENCY_LEVEL, consistencyLevel);
    }

    string? continuationToken = requestOptions["continuationToken"];
    if (continuationToken is string) {
        request.setHeader(CONTINUATION, continuationToken);
    }

    int? partitionKeyRangeId = requestOptions["partitionKeyRangeId"];
    if (partitionKeyRangeId is int) {
        request.setHeader(PARTITION_KEY_RANGE_ID, <string>partitionKeyRangeId);
    }

    int? pageSize = requestOptions["pageSize"];
    if (pageSize is int) {
        request.setHeader(PAGE_SIZE, <string>pageSize);
    }
}

function extractResponseHeaders(http:Response httpResponse) returns ResourceResponse {
    ResourceResponse resourceResponse = {};
    if (httpResponse.hasHeader(ETAG)) {
        resourceResponse.etag = httpResponse.getHeader(ETAG);
    }
    if (httpResponse.hasHeader(ACTIVITY_ID)) {
        resourceResponse.activityId = httpResponse.getHeader(ACTIVITY_ID);
    }
    if (httpResponse.hasHeader(OWNER_FULL_NAME)) {
        resourceResponse.activityId = httpResponse.getHeader(OWNER_FULL_NAME);
    }
    if (httpResponse.hasHeader(SESSION_TOKEN)) {
        resourceResponse.sessionToken = httpResponse.getHeader(SESSION_TOKEN);
    }
    return resourceResponse;
}

function setResponseError(string errorMessage) returns error {
    error err = error(COSMOS_DB_ERROR_CODE, { message: errorMessage });
    return err;
}

function generatePayload(string queryString, any... parameters) returns json|error {
    string generatedQuery = queryString;
    json[] jsonParameters =[];
    int i = 0;
    if (parameters.length() != 0) {
        foreach var param in parameters {
            string id = system:uuid();
            json jsonParam = { "name" : id };
            var jsonVal = json.convert(param);
            if (jsonVal is json) {
                jsonParam.value = jsonVal;
            } else {
                return setResponseError(JSON_CONVERSION_ERROR_MSG);
            }
            generatedQuery = generatedQuery.replaceFirst("[?]+", "@" + id);
            jsonParameters[i] = jsonParam;
            i = i + 1;
        }
    }
    return { "query" : generatedQuery, "parameters" : jsonParameters };
}
