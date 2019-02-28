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

import ballerina/config;
import ballerina/io;
import ballerina/test;

CosmosDBConfiguration cosmosDBConfig = {
    baseURL: config:getAsString("BASE_URL"),
    masterKey: config:getAsString("MASTER_KEY")
};

Client cosmosdbClient = new(cosmosDBConfig);
string databaseID = "testBallarinaDB2";
string collectionID = "testBallarinaColl2";
string documentID = "testBallarinaDoc2";

@test:Config
function testCreateDatabase() {
    io:println("-----------------Test case for createDatabase method------------------");
    var dbRes = cosmosdbClient->createDatabase(databaseID);
    if (dbRes is DatabaseResponse) {
        test:assertNotEquals(dbRes.database.id, null, msg = "Failed to create database");
    } else {
        io:println(<string>dbRes.detail().message);
        test:assertFail(msg = <string>dbRes.detail().message);
    }
}

@test:Config {
    dependsOn: ["testCreateDatabase"]
}
function testGetDatabase() {
    io:println("-----------------Test case for getDatabase method------------------");
    var dbRes = cosmosdbClient->getDatabase(databaseID);
    if (dbRes is DatabaseResponse) {
        test:assertNotEquals(dbRes.database.id, null, msg = "Failed to get database");
    } else {
        test:assertFail(msg = <string>dbRes.detail().message);
    }
}

@test:Config {
    dependsOn: ["testCreateDatabase"]
}
function testListDatabases() {
    io:println("-----------------Test case for getDatabase method------------------");
    var dbRes = cosmosdbClient->listDatabases();
    if (dbRes is DatabaseListResponse) {
        io:println(dbRes);
        test:assertNotEquals(dbRes.databases, null, msg = "Failed to get database");
    } else {
        test:assertFail(msg = <string>dbRes.detail().message);
    }
}

@test:Config {
    dependsOn: ["testCreateDatabase", "testGetDatabase", "testListDatabases", "testListCollections",
    "testDeleteCollection", "testDeleteDocument"]
}
function testDeleteDatabase() {
    io:println("-----------------Test case for deleteDatabase method------------------");
    var dbRes = cosmosdbClient->deleteDatabase(databaseID);
    if (dbRes is ResourceResponse) {
        test:assertNotEquals(dbRes, null, msg = "Failed to delete database");
    } else {
        test:assertFail(msg = <string>dbRes.detail().message);
    }
}

@test:Config {
    dependsOn: ["testCreateDatabase"]
}
function testCreateCollection() {
    io:println("-----------------Test case for createCollection method------------------");
    var dbRes = cosmosdbClient->createCollection(databaseID, collectionID);
    if (dbRes is CollectionResponse) {
        test:assertNotEquals(dbRes.collection.id, null, msg = "Failed to create collection");
    } else {
        test:assertFail(msg = <string>dbRes.detail().message);
    }
}

@test:Config {
    dependsOn: ["testCreateCollection"]
}
function testListCollections() {
    io:println("-----------------Test case for listCollections method------------------");
    var dbRes = cosmosdbClient->listCollections(databaseID);
    if (dbRes is DocumentCollectionsResponse) {
        io:println(dbRes);
        test:assertNotEquals(dbRes.documentCollections, null, msg = "Failed to list collections");
    } else {
        test:assertFail(msg = <string>dbRes.detail().message);
    }
}

@test:Config {
    dependsOn: ["testCreateCollection"]
}
function testGetCollection() {
    io:println("-----------------Test case for getCollection method------------------");
    var dbRes = cosmosdbClient->getCollection(databaseID, collectionID);
    if (dbRes is CollectionResponse) {
        test:assertNotEquals(dbRes.collection.id, null, msg = "Failed to get collection");
    } else {
        test:assertFail(msg = <string>dbRes.detail().message);
    }
}

@test:Config {
    dependsOn: ["testCreateCollection", "testGetCollection", "testListCollections", "testListDocuments",
    "testDeleteDocument"]
}
function testDeleteCollection() {
    io:println("-----------------Test case for deleteDatabase method------------------");
    var dbRes = cosmosdbClient->deleteCollection(databaseID, collectionID);
    if (dbRes is ResourceResponse) {
        test:assertNotEquals(dbRes, null, msg = "Failed to delete collection");
    } else {
        test:assertFail(msg = <string>dbRes.detail().message);
    }
}

@test:Config {
    dependsOn: ["testCreateDatabase", "testCreateCollection"]
}
function testCreateDocument() {
    io:println("-----------------Test case for createDocument method------------------");
    json content = {
        "id": "AndersenFamily",
        "LastName": "Andersen",
        "Parents": [
            {
                "FamilyName": null,
                "FirstName": "Thomas"
            },
            {
                "FamilyName": null,
                "FirstName": "Mary Kay"
            }
        ],
        "Children": [
            {
                "FamilyName": null,
                "FirstName": "Henriette Thaulow",
                "Gender": "female",
                "Grade": 5,
                "Pets": [
                    {
                        "GivenName": "Fluffy"
                    }
                ]
            }
        ],
        "Address": {
            "State": "WA",
            "County": "King",
            "City": "Seattle"
        },
        "IsRegistered": true
    };
    DocumentCreateOptions documentCreateOptions = {};
    var dbRes = cosmosdbClient->createDocument(databaseID, collectionID, documentID, content);
    if (dbRes is ResourceResponse) {
        test:assertNotEquals(dbRes, null, msg = "Failed to create documentation");
    } else {
        test:assertFail(msg = <string>dbRes.detail().message);
    }
}

@test:Config {
    dependsOn: ["testCreateDocument"]
}
function testListDocuments() {
    io:println("-----------------Test case for listDocuments method------------------");
    DocumentListOptions documentListOptions = { maxItemCount: 2 };
    var dbRes = cosmosdbClient->listDocuments(databaseID, collectionID, documentListOptions = documentListOptions);
    if (dbRes is DocumentListResponse) {
        test:assertNotEquals(dbRes.documents, null, msg = "Failed to list documents");
    } else {
        test:assertFail(msg = <string>dbRes.detail().message);
    }
}

@test:Config {
    dependsOn: ["testCreateDocument"]
}
function testQueryDocuments() {
    io:println("-----------------Test case for listDocuments method------------------");
    DocumentQueryOptions documentQueryOptions = { maxItemCount: 2 };
    string queryString = "SELECT * FROM Families f WHERE f.id = ? AND f.Address.City = ?";
    var dbRes = cosmosdbClient->queryDocuments(databaseID, collectionID, queryString,
        documentQueryOptions = documentQueryOptions, "AndersenFamily", "Seattle");
    if (dbRes is DocumentListResponse) {
        io:println(dbRes);
        test:assertNotEquals(dbRes.documents, null, msg = "Failed to list documents");
    } else {
        test:assertFail(msg = <string>dbRes.detail().message);
    }
}

@test:Config {
    dependsOn: ["testCreateDocument"]
}
function testGetDocument() {
    io:println("-----------------Test case for getDocument method------------------");
    var dbRes = cosmosdbClient->getDocument(databaseID, collectionID, documentID);
    if (dbRes is DocumentResponse) {
        io:println(dbRes);
        test:assertEquals(dbRes.document.id, documentID, msg = "Failed to list documents");
    }
}

@test:Config {
    dependsOn: ["testCreateDocument", "testListDocuments", "testQueryDocuments", "testGetDocument"]
}
function testDeleteDocument() {
    io:println("-----------------Test case for deleteDocument method------------------");
    var dbRes = cosmosdbClient->deleteDocument(databaseID, collectionID, documentID);
    if (dbRes is ResourceResponse) {
        test:assertNotEquals(dbRes, null, msg = "Failed to delete collection");
    } else {
        test:assertFail(msg = <string>dbRes.detail().message);
    }
}
