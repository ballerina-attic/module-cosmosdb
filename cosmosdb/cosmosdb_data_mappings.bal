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

function convertToDatabaseResponse(json jsonResponse) returns DatabaseResponse {
    DatabaseResponse databaseResponse = {};
    databaseResponse.database = convertToDatabase(jsonResponse);
    return databaseResponse;
}

function convertToDatabase(json jsonResponse) returns Database {
    Database database = {};
    database.id = jsonResponse.id.toString();
    database.rid = jsonResponse._rid.toString();
    return database;
}

function convertToDatabaseListResponse(json jsonResponse) returns DatabaseListResponse {
    DatabaseListResponse databaseListResponse = {};
    if (jsonResponse.Databases != ()) {
        json[] jsonDatabases = <json[]>jsonResponse.Databases;
        int i = 0;
        foreach json jsonDatabase in jsonDatabases {
            databaseListResponse.databases[i] = convertToDatabase(jsonDatabase);
            i = i + 1;
        }
    }
    return databaseListResponse;
}

function convertToCollectionResponse(json jsonResponse) returns CollectionResponse {
    CollectionResponse collectionResponse = {};
    collectionResponse.collection = convertToDatabase(jsonResponse);
    return collectionResponse;
}

function convertToCollection(json jsonResponse) returns Collection {
    Collection collection = {};
    collection.id = jsonResponse.id.toString();
    collection.rid = jsonResponse._rid.toString();
    return collection;
}

function convertToDocumentCollectionsResponse(json jsonResponse) returns DocumentCollectionsResponse {
    DocumentCollectionsResponse documentCollectionsResponse = {};
    documentCollectionsResponse.count = <int>jsonResponse._count;
    if (jsonResponse.DocumentCollections != ()) {
        json[] jsonDocumentCollections = <json[]>jsonResponse.DocumentCollections;
        int i = 0;
        foreach json jsonCollection in jsonDocumentCollections {
            documentCollectionsResponse.documentCollections[i] = convertToCollection(jsonCollection);
            i = i + 1;
        }
    }
    return documentCollectionsResponse;
}

function convertToDocument(json jsonResponse) returns Document {
    Document document = {};
    document.id = jsonResponse.id.toString();
    document.rid = jsonResponse._rid.toString();
    document.etag = jsonResponse._etag.toString();
    json jsonContent = getJSONContent(jsonResponse);
    document.content =  jsonContent.length() != 0 ? jsonContent : ();
    return document;
}

function getJSONContent(json jsonResponse) returns json {
    jsonResponse.remove("id");
    jsonResponse.remove("_rid");
    jsonResponse.remove("_self");
    jsonResponse.remove("_etag");
    jsonResponse.remove("_attachments");
    jsonResponse.remove("_ts");
    return jsonResponse;
}

function convertToDocumentListResponse(json jsonResponse) returns DocumentListResponse {
    DocumentListResponse documentListResponse = {};
    if (jsonResponse.Documents != ()) {
        json[] jsonDocuments = <json[]>jsonResponse.Documents;
        int i = 0;
        foreach json jsonDocument in jsonDocuments {
            documentListResponse.documents[i] = convertToDocument(jsonDocument);
            i = i + 1;
        }
    }
    return documentListResponse;
}
