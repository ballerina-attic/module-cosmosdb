# Ballerina Azure Cosmos DB Endpoint

The Cosmos DB endpoint allows you to access the Cosmos DB through Ballerina.

The following sections provide you with information on how to use the Ballerina Cosmos DB endpoint.
- [Compatibility](#compatibility)
- [Working with CosmosDB Endpoint Remote Functions](#working-with-cosmosdb-endpoint-remote-functions)


### Compatibility

| Ballerina Language Version  | Azure Cosmos DB API Version    |
|:---------------------------:|:------------------------------:|
|  0.990.0                    |   2017-02-22                   |

##### Prerequisites
Download the ballerina [distribution](https://ballerina.io/downloads/).

##### Contribute To Develop
Clone the repository by running the following command
`git clone https://github.com/wso2-ballerina/module-cosmosdb.git`

## Working with CosmosDB Endpoint Remote Functions
All the actions return valid response or error. If the action is a success, then the requested resource will
be returned. Else error will be returned.

In order for you to use the CosmosDB Endpoint, first you need to create a CosmosDB Client endpoint.

```ballerina
import wso2/cosmosdb;

CosmosDBConfiguration cosmosDBConfig = {
    baseURL: <your_account_base_url>,
    masterKey: <your_account_master_key>
};

Client c = new(cosmosDBConfig);
```

Then the endpoint remote functions can be invoked as `var response = cosmosDB->functionName(arguments)`.

#### Sample
```ballerina
import ballerina/config;
import ballerina/io;
import wso2/cosmosdb;

public function main() {
    cosmosdb:CosmosDBConfiguration cosmosDBConfig = {
        baseURL: config:getAsString("BASE_URL"),
        masterKey: config:getAsString("MASTER_KEY")
    };

    cosmosdb:Client cosmosdbClient = new(cosmosDBConfig);

    var dbRes = cosmosdbClient->createDatabase(databaseID);
    if (dbRes is cosmosdb:DatabaseResponse) {
        io:println(dbRes);
    } else {
        //Error will be printed
        io:println(dbRes);
    }
}
```
