
## Making a release commit & sharing build

- Update the changelog
- Update the pubspec.yaml file
- Run :
```
$ git add .
$ git commit -m '[Release] Release 34 v124.5.4'
$ git tag v124.5.4
$ git push
$ git push --tags
```
NOTE: *This repository uses github actions to build and share the apk automatically. The build will be shared by e-mail on making a release commit and through slack channel (flutter-mt-app) on tags push. See .github/workflows/release-push-develop.yml for e-mail share workflow and .github/workflows/slack-share.yml for slack channel share workflow.*

## Sharing APK manually

### DEBUG

```
$ flutter clean
$ flutter build apk --flavor dev -t lib/main_dev.dart --no-sound-null-safety
```
or
```
make builddev
```

### PROD

```
$ flutter clean
$ flutter build apk --flavor prod -t lib/main_prod.dart --no-sound-null-safety
```
or
```
make buildprod
```

NOTE: *To use make in terminal you first have to install make in your system, to do so visit this [link](https://techdocs.fieldassist.io/learning/makefile.html)*

## Build naming convention

Use `fa-mt-v124_3_2` as example.

## Publishing build

### Android App Bundle

```
flutter clean && flutter build appbundle --target lib/main_prod.dart --flavor prod --no-sound-null-safety
```
or
```
make buildbundle
```

NOTE: *To use make in terminal you first have to install make in your system, to do so visit this [link](https://techdocs.fieldassist.io/learning/makefile.html)*

## Extra(s)

- FA Flutter Best Practices: https://github.com/FieldAssist/fa_flutter_docs)
- For Json building or editing auto route
```
flutter pub get && flutter pub run build_runner build --delete-conflicting-outputs
```
or
```
make freezed
```

NOTE: *To use make in terminal you first have to install make in your system, to do so visit this [link](https://techdocs.fieldassist.io/learning/makefile.html)*

## More details

Contact *FA Flutter Team*

## ✨ Active Contributors

Thanks goes to these wonderful people:

<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore-start -->
<!-- markdownlint-disable -->
<table>
  <tr>
    <td align="center"><a href="https://github.com/TusharFA"><img src="https://avatars.githubusercontent.com/u/82998121?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Tushar Sharma</b></sub></a><br /></td>
    <td align="center"><a href="https://github.com/sam1kumar"><img src="https://avatars.githubusercontent.com/u/86761543?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Sameer Kumar</b></sub></a><br /></td>
  </tr>

</table>
