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

public type RequestOptions record {
    string consistencyLevel?;
    string sessionToken?;
    int partitionKeyRangeId?;
    string continuationToken?;
    int pageSize?;
};

public type ResourceResponse record {
    string etag?;
    string activityId?;
    string alternateContentPath?;
    int itemCount?;
    int maxResourceQuota?;
    int currentResourceUsage?;
    string sessionToken?;
    int requestCharge?;
};

public type DatabaseResponse record {
    ResourceResponse resourceResponse = {};
    Database database = {};
};

public type Database record {
    string id = "";
    string rid = "";
};

public type DatabaseListResponse record {
    ResourceResponse resourceResponse = {};
    Database[] databases = [];
};

public type DocumentCollectionsResponse record {
    ResourceResponse resourceResponse = {};
    Collection[] documentCollections = [];
    int count = 0;
};

public type CollectionCreateOptions record {
    RequestOptions requestOptions = {};
    int offerThroughput?;
    string offerType?;
};

public type CollectionResponse record {
    ResourceResponse resourceResponse = {};
    Collection collection = {};
};

public type DocumentQueryOptions record {
    RequestOptions requestOptions = {};
    int maxItemCount?;
};

public type DocumentCreateOptions record {
    RequestOptions requestOptions = {};
    boolean isDocumentUpsert = false;
    string indexingDirective = "";
};

public type Collection record {
    string id = "";
    string rid = "";
};

public type Document record {
    string id?;
    string rid?;
    string etag?;
    json content?;
};

public type DocumentListResponse record {
    Document[] documents = [];
    int count?;
};

public type DocumentResponse record {
    ResourceResponse resourceResponse = {};
    Document document = {};
};

public type DocumentListOptions record {
    int maxItemCount?;
    RequestOptions requestOptions = {};
};
