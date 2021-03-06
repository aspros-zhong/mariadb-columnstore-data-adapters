# MariaDB ColumnStore - Pentaho Data Integration - Bulk Loader Plugin
This provides the source files for MariaDB's ColumunStore bulk loader plugin, to inject data into ColumnStore via PDI.

## Compatibility notice
This plugin was designed for following software composition:
* OS: Ubuntu 16.04, RHEL/CentOS<sup>+</sup> 7
* MariaDB ColumnStore >= 1.1.4 
* MariaDB Java Database client<sup>*</sup> >= 2.2.1 
* Java >= 8 
* PDI >= 7

<sup>+</sup>not officially supported by Pentaho.

<sup>*</sup>only needed if you want to execute DDL.

## Building the plugin from source
Follow this steps to build the plugin from source.

### Requirements
These requirements need to be installed prior building:
* MariaDB AX Bulk Data Adapters 1.1.5 (an DEB/RPM is provided by [MariaDB](https://mariadb.com/downloads/mariadb-ax/data-adapters))
* Java SDK 8 or higher
* chrpath (sudo apt-get install chrpath || sudo yum install chrpath)

### Build process
To build the plugin from source execute following commands:
```shell
git clone https://github.com/mariadb-corporation/mariadb-columnstore-data-adapters.git
cd mariadb-columnstore-data-adapters/kettle-columnstore-bulk-exporter-plugin
./gradlew [-PmcsapiLibPath="include this custom mcsapi path"] [-Pversion="x.y.z"] plugin
```
The built plugin can be found in _build/distributions/_

## Installation of the plugin in PDI / Kettle
Following steps are necessary to install the ColumnStore bulk loader plugin.
1. build the plugin from source or download it from our [website](https://mariadb.com/downloads/mariadb-ax/data-adapters)
2. extract the archive _kettle-columnstore-bulk-exporter-plugin-*.zip_ into your PDI installation directory _$PDI-INSTALLATION/plugins_.
3. copy [MariaDB's JDBC Client](https://mariadb.com/downloads/mariadb-ax/connector) _mariadb-java-client-2.2.x.jar_ into PDI's lib directory _$PDI-INSTALLATION/lib_.
4. install the additional library dependencies

### Ubuntu dependencies
```shell
sudo apt-get install libuv1
```

### CentOS dependencies
```shell
sudo yum install epel-release
sudo yum install libuv
```

## Configuration
By default the plugin tries to use ColumnStore's default configuration _/usr/local/mariadb/columnstore/etc/Columnstore.xml_ to connect to the ColumnStore instance through the Bulk Write SDK.

Individual configurations can be assigned within each block.

Information on how to change the _Columnstore.xml_ configuration file to connect to remote ColumnStore instances can be found in our  [Knowledge Base](https://mariadb.com/kb/en/library/columnstore-bulk-write-sdk/#environment-configuration).

## Testing
All continious integration test jobs are in the _test_ directory and can be either loaded manually into kettle or be executed through

```shell
./test/test.sh
```

This script will download PDI 7, install the build plugin and MariaDB JDBC driver, and execute the tests residing in the tests sub-directories.

You might have to change the database connection properties set in _job.parameter_, according to your ColumnStore setup.

### all-datatype-ingestion-test
This job runs a basic ingestion test of all datatypes into ColumnStore and InnoDB tables and compares the results.

### csv-ingestion-test
Ingests two csv files, to ColumnStore. Possible to adapt the number of ingestion loops to run in _job.parameter_.

Currently only tests if the job is executed, but not if the ingestion was successful.

## Limitations
The plugin currently can't handle blob datatypes and only supports multi inputs to one block if the input field names are equal for all input sources.
