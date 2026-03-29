# CoreMedia Content Cloud App Stub Preparation

The script in this repository can be used to add new custom apps to your
CoreMedia Content Cloud Blueprints Workspace.

## Status and Feedback

This was just a starting point to add another component to the apps section
of the Blueprints Workspace, which should be considered a project specific
addition handled the same way as the other components in the workspace.

With currect architecture situations and the CMCC on cloud services, this can
be at least considered in state "handle with care" not to say "most likely not
recommended for new projects".

Please contribute or give [feedback][issues] via the usual [GitHub][github] means.

## Usage

```
./app-create.sh EXISTING-TARGET-DIRECTORY APP-NAME
```

## Sample

```
mkdir $COREM_BLUEPRINTS_ROOT/custom-apps/abc-image-feeder
cd cmccAppCreator
./app-create.sh $COREM_BLUEPRINTS_ROOT/custom-apps/abc-image-feeder abc-image-feeder
```

## Function

The script creates the following basic sub folder structure with maven poms
and a Dockerfile for an app inside of the CoreMedia Content Cloud 10 Blueprints
Workspace:

```    
pom.xml
├── blueprint-parent
│   └── pom.xml
├── docker
│   ├── APP_NAME-app
│   │   ├── Dockerfile
│   │   └── pom.xml
│   └── pom.xml
├── APP_NAME-blueprint-bom
│   └── pom.xml
├── modules
│   └── pom.xml
└── spring-boot
    ├── APP_NAME-app (with scr/main/[java|resources] boilerplates 
    │   └── pom.xml
    └── pom.xml
```

The [base workspace itself is available in from CoreMedia][coremedia-blueprints]. 
Please consult the [Product Homepage][coremedia].

[coremedia]: https://www.coremedia.com/
[coremedia-blueprints]: https://github.com/coremedia-contributions/coremedia-blueprints-workspace/tree/cmcc-10-1907
[issues]: https://github.com/blackappsolutions/cmccAppCreator/issues
[github]: https://github.com/
