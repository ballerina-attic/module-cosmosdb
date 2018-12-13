// Copyright (c) 2018 WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
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

final string DB_PATH = "dbs";
final string COLL_PATH = "colls";
final string DOC_PATH = "docs";


final string MASTER_TOKEN = "master";
final string TOKEN_VERSION = "1.0";
final string X_MS_VERSION = "2017-02-22";
final string DATE_TIME_FORMAT = "EEE, dd MMM yyyy HH:mm:ss z";

final string JSON_CONTENT_TYPE = "application/json";
final string QUERY_JSON_CONTENT_TYPE = "application/query+json";

//Symbols
final string NEW_LINE = "\n";
final string SLASH = "/";
final string EMPTY_STRING = "";

// Error Codes
final string COSMOS_DB_ERROR_CODE = "(wso2/cosmosdb)CosmosDbError";

//Headers
final string ETAG = "etag";
final string SESSION_TOKEN = "x-ms-session-token";
final string ACTIVITY_ID = "x-ms-activity-id";
final string CONSISTENCY_LEVEL = "x-ms-consistency-level";
final string X_DATE = "x-ms-date";
final string MAX_RESOURCE_QUOTA = "x-ms-resource-quota";
final string CURRENT_RESOURCE_QUOTA_USAGE = "x-ms-resource-usage";
final string CONTINUATION = "x-ms-continuation";
final string PAGE_SIZE = "x-ms-max-item-count";
final string REQUEST_CHARGE = "x-ms-request-charge";
final string VERSION = "x-ms-version";
final string OWNER_FULL_NAME = "x-ms-alt-content-path";
final string RETRY_AFTER_IN_MILLISECONDS = "x-ms-retry-after-ms";
final string PARTITION_KEY = "x-ms-documentdb-partitionkey";
final string PARTITION_KEY_RANGE_ID = "x-ms-documentdb-partitionkeyrangeid";
final string MAX_ITEM_COUNT = "x-ms-max-item-count";
final string IS_QUERY = "x-ms-documentdb-isquery";


public const INCLUDE = "Include";
public const EXCLUDE = "Exclude";
public type INDEXING_DIRECTIVE "Include"|"Exclude";
