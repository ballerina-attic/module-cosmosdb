//
// Copyright (c) 2018, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
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
//

import ballerina/time;
import ballerina/http;
import ballerina/crypto;
import ballerina/system;

string dateString = "";

function costructRequestHeaders(http:Request request, string httpMethod, string resourceType, string resourceLink,
                                string masterKey, string contentType, RequestOptions? requestOptions = ()) returns error
                                                                                                                   ? {
    time:Time time = time:currentTime();
    time:Timezone zoneValue = { zoneId: "GMT" };
    time:Time standardTime = new(time.time, zoneValue);
    dateString = standardTime.format(DATE_TIME_FORMAT);

    string stringToSign = httpMethod.toLower() + NEW_LINE + resourceType.toLower() + NEW_LINE + resourceLink
        + NEW_LINE + dateString.toLower() + NEW_LINE + EMPTY_STRING + NEW_LINE;
    string signature = crypto:hmac(stringToSign, masterKey, keyEncoding = crypto:BASE64,
        crypto:SHA256).base16ToBase64Encode();
    string authHeaderString = check http:encode("type=" + MASTER_TOKEN + "&ver=" + TOKEN_VERSION + "&sig=" + signature,
        "UTF-8");
    request.setHeader("Authorization", authHeaderString);
    request.setHeader("x-ms-version", X_MS_VERSION);
    request.setHeader("x-ms-date", dateString);
    request.setHeader("content-type", contentType);
    if (requestOptions != ()) {
        var requestHeaders = setOptionalHeaders(request, requestOptions = requestOptions);
        if (requestHeaders is error) {
            error err = error(COSMOS_DB_ERROR_CODE,
            { message: "Error occurred while constructing request optional headers" });
            return err;
        }
    }
    return ();
}

function setOptionalHeaders(http:Request request, RequestOptions? requestOptions = ()) returns error? {
    string sessionToken = requestOptions["sessionToken"] ?: "";
    if (sessionToken != "") {
        request.setHeader(SESSION_TOKEN, sessionToken);
    }

    string consistencyLevel = requestOptions["consistencyLevel"] ?: "";
    if (consistencyLevel != "") {
        request.setHeader(CONSISTENCY_LEVEL, consistencyLevel);
    }

    string continuationToken = requestOptions["continuationToken"] ?: "";
    if (continuationToken != "") {
        request.setHeader(CONTINUATION, continuationToken);
    }

    int partitionKeyRangeId = requestOptions["partitionKeyRangeId"] ?: 0;
    if (partitionKeyRangeId != 0) {
        request.setHeader(PARTITION_KEY_RANGE_ID, <string>partitionKeyRangeId);
    }

    int pageSize = requestOptions["pageSize"] ?: -1;
    if (pageSize != -1) {
        request.setHeader(PAGE_SIZE, <string>pageSize);
    }
    return ();
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

function setResponseError(json jsonResponse) returns error {
    error err = error(COSMOS_DB_ERROR_CODE, { message: jsonResponse.message.toString() });
    return err;
}

function generatePayload(string queryString, any... parameters) returns json|error {
    string generatedQuery = queryString;
    json[] jsonParameters =[];
    int i = 0;
    if (parameters.length() != 0) {
        foreach var param in parameters {
            string id = system:uuid();
            json jsonParam = {"name" : id};
            var jsonVal = json.convert(param);
            if (jsonVal is json) {
                jsonParam.value = jsonVal;
            } else {
                error err = error(COSMOS_DB_ERROR_CODE,
                { message: "Error occurred while converting the value as json" });
                return err;
            }
            generatedQuery = generatedQuery.replaceFirst("[?]+", "@" + id);
            jsonParameters[i] = jsonParam;
            i = i + 1;
        }
    }
    json jsonPayload = {"query" : generatedQuery, "parameters" : jsonParameters};
    return {"query" : generatedQuery, "parameters" : jsonParameters};
}
