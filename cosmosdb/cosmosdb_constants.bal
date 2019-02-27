// Copyright (c) 2019 WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
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

const string DB_PATH = "dbs";
const string COLL_PATH = "colls";
const string DOC_PATH = "docs";


const string MASTER_TOKEN = "master";
const string TOKEN_VERSION = "1.0";
const string X_MS_VERSION = "2017-02-22";
const string DATE_TIME_FORMAT = "EEE, dd MMM yyyy HH:mm:ss z";

const string JSON_CONTENT_TYPE = "application/json";
const string QUERY_JSON_CONTENT_TYPE = "application/query+json";

//Symbols
const string NEW_LINE = "\n";
const string SLASH = "/";
const string EMPTY_STRING = "";

// Error Codes
const string COSMOS_DB_ERROR_CODE = "(wso2/cosmosdb)CosmosDbError";
const string HEADER_CONST_ERROR_MSG = "Error occurred while encoding parameters when constructing request headers";
const string JSON_EXTRACTION_ERROR_MSG = "Error occurred while accessing the JSON payload of the response";
const string JSON_CONVERSION_ERROR_MSG = "Error occurred while converting the value as json";
const string API_INVOCATION_ERROR_MSG = "Error occurred while invoking the REST API";
const string ENCODING_ERROR_MSG = "Error occurred while encoding parameters when constructing request headers";

//Headers
const string ETAG = "etag";
const string SESSION_TOKEN = "x-ms-session-token";
const string ACTIVITY_ID = "x-ms-activity-id";
const string CONSISTENCY_LEVEL = "x-ms-consistency-level";
const string X_DATE = "x-ms-date";
const string MAX_RESOURCE_QUOTA = "x-ms-resource-quota";
const string CURRENT_RESOURCE_QUOTA_USAGE = "x-ms-resource-usage";
const string CONTINUATION = "x-ms-continuation";
const string PAGE_SIZE = "x-ms-max-item-count";
const string REQUEST_CHARGE = "x-ms-request-charge";
const string VERSION = "x-ms-version";
const string OWNER_FULL_NAME = "x-ms-alt-content-path";
const string RETRY_AFTER_IN_MILLISECONDS = "x-ms-retry-after-ms";
const string PARTITION_KEY = "x-ms-documentdb-partitionkey";
const string PARTITION_KEY_RANGE_ID = "x-ms-documentdb-partitionkeyrangeid";
const string MAX_ITEM_COUNT = "x-ms-max-item-count";
const string IS_QUERY = "x-ms-documentdb-isquery";
const string IS_UPSERT = "x-ms-documentdb-is-upsert";
const string CONTENT_TYPE = "content-type";
const string AUTHORIZATION = "Authorization";
const string OFFER_THROUGHPUT = "x-ms-offer-throughput";
const string OFFER_TYPE = "x-ms-offer-type";
const string INDEXING_DIRECTIVE = "x-ms-indexing-directive";


public const INCLUDE = "Include";
public const EXCLUDE = "Exclude";
public type INDEXING_DIRECTIVE_TYPE "Include"|"Exclude";
