Connects to Azure Cosmos DB from Ballerina.

# Module Overview

The Azure Cosmos DB connector allows you to create and access the Azure Cosmos DB through the Azure Cosmos DB REST API.

**CosmosDB Operations**

The `wso2/cosmosdb` module contains operations that create, retrieve, or delete databases, collections, and documents. It also allows you to query the documents.

## Compatibility

|                             |       Version               |
|:---------------------------:|:---------------------------:|
| Ballerina Language          | 0.990.3                     |
| Azure Cosmos DB API Version | 2017-02-22                  |

## Sample

Import the `wso2/cosmosdb` module into the Ballerina project.
```ballerina
import wso2/cosmosdb;
```
Azure Cosmos DB connector can be instantiated using the account base URL and master key of your account in the CosmosDB configuration.
You can obtain the master key using following steps:

1. Sign in to the [Azure portal](https://portal.azure.com/), click **Create a resource**, select **Databases** and **Azure Cosmos DB** and enter the basic settings for the new Azure Cosmos DB account.
2. Select the created database, and click **keys**, and get the master key (use secondary key if you are not the owner of the Azure account).

You can now enter the credentials in the HTTP client config:
```ballerina
cosmosdb:CosmosDBConfiguration cosmosDBConfig = {
    baseURL: <your_db_account_base_url>,
    masterKey: <your_account_master_key>
};

cosmosdb:Client cosmosdbClient = new(cosmosDBConfig);
```
The `createDatabase` function creates a new database with the given name.
```ballerina
// Create a database.
var response = cosmosdbClient->createDatabase(databaseId);
```
The response from `createDatabase` is a `DatabaseResponse` object if the request was successful or an `error` on failure.
```ballerina
if (dbRes is cosmosdb:DatabaseResponse) {
        io:println(dbRes);
    } else {
        // Error will be printed.
        io:println("Error: ", dbRes);
    }
```
