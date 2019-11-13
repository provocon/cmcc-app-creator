## Usage
```shell script
./createCmccAppFolderStructure.sh EXISTING-TARGET-DIRECTORY APP-NAME
```    

##Function
The script creates the following basic sub folder structure with maven poms and a Dockerfile for an app inside of the
[CoreMedia Content Cloud 10 - Blueprint Workspace](https://github.com/coremedia-contributions/coremedia-blueprints-workspace/tree/cmcc-10-1907):
```
├── blueprint-parent
│   └── pom.xml
├── docker
│   ├── importer-app
│   │   ├── Dockerfile
│   │   └── pom.xml
│   └── pom.xml
├── importer-blueprint-bom
│   └── pom.xml
├── modules
│   └── pom.xml
└── spring-boot
    ├── importer-app
    │   └── pom.xml
    └── pom.xml
```
This is just a starting point. Please contribute or give feedback.

Product Homepage: https://www.coremedia.com/
