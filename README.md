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
Download the Ballerina [distribution](https://ballerina.io/downloads/).

##### Contribute To Develop
Clone the repository by running the following command:
`git clone https://github.com/wso2-ballerina/module-cosmosdb.git`

## Working with CosmosDB Endpoint Remote Functions
All the remote functions return valid responses or errors. If the remote function is a success, then the requested resource is returned. Alternatively, error is returned.

Create a CosmosDB Client endpoint to use the CosmosDB Endpoint.

```ballerina
import wso2/cosmosdb;

cosmosdb:CosmosDBConfiguration cosmosDBConfig = {
    baseURL: <your_account_base_url>,
    masterKey: <your_account_master_key>
};

cosmosdb:Client c = new(cosmosDBConfig);
```

The endpoint remote functions can be invoked using `var response = cosmosDB->functionName(arguments)`.

#### Sample
```ballerina
import ballerina/config;
import ballerina/io;
import wso2/cosmosdb;

public function main() {
    // CosmosDB configuration
    cosmosdb:CosmosDBConfiguration cosmosDBConfig = {
        baseURL: config:getAsString("BASE_URL"),
        masterKey: config:getAsString("MASTER_KEY")
    };

    // Create the CosmosDB client.
    cosmosdb:Client cosmosdbClient = new(cosmosDBConfig);

    // Invoke createDatabase function.
    var dbRes = cosmosdbClient->createDatabase(databaseID);
    if (dbRes is cosmosdb:DatabaseResponse) {
        io:println(dbRes);
    } else {
        //Error is printed.
        io:println(dbRes);
    }
}
```
