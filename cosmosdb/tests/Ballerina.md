## Compatibility

| Ballerina Language Version  | Azure Cosmos DB API Version    |
| ----------------------------| -------------------------------|
|  0.990.0                    |   2017-02-22                   |

### Prerequisites

1. Create a database by visiting [Azure portal](https://portal.azure.com/)
2. Obtain the master key.

Visit [here](https://docs.microsoft.com/en-us/rest/api/cosmos-db/access-control-on-cosmosdb-resources) for more information on obtaining master key.

## Running Samples
You can use the `tests.bal` file to test all the connector actions by following the below steps:
1. Create ballerina.conf file in module-cosmosdb.
2. Obtain the client Id, client secret, access token and refresh token as mentioned above and add those values in the ballerina.conf file.
    ```
    BASE_URL="<your_db_account_url>"
    MASTER_KEY="<your_master_key>"
    ```

3. Navigate to the folder `module-cosmosdb`.
4. Run the following commands to execute the tests.
    ```
    ballerina init
    ballerina test cosmosdb --config ballerina.conf
    ```
