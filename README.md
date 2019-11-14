# CoreMedia Content Cloud App Stub Preparation

The script in this repository can be used to add new custom apps to your 
CoreMedia Content Cloud Blueprints Workspace.

## Status and Feedback

This is just a starting point. Please contribute or give [feedback][issues] via 
the usual [github][github] means.

## Usage

```
./app-create.sh EXISTING-TARGET-DIRECTORY APP-NAME
```    

## Function

The script creates the following basic sub folder structure with maven poms 
and a Dockerfile for an app inside of the CoreMedia Content Cloud 10 Blueprints
Workspace:

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

The [base workspace itself is available in from CoreMedia][coremedia--blueprints]. 
Please consult the [Product Homepage][coremedia].

[coremedia]: https://www.coremedia.com/
[coremedia-prints]: https://github.com/coremedia-contributions/coremedia-blueprints-workspace/tree/cmcc-10-1907
[issues]: https://github.com/blackappsolutions/cmccAppCreator/issues
[github]: https://github.com/
