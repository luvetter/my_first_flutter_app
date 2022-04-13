# Nützliche Links
- [pub.dev als Package-Manager](https://pub.dev)
- [Die flutter-favorites von pub.dev](https://pub.dev/packages?q=is%3Aflutter-favorite)
- [Tutorials von flutter.dev](https://flutter.dev/learn)
- [Templates von docs.flutter.dev](https://docs.flutter.dev/cookbook)
- [flutter auf Youtube](https://www.youtube.com/c/flutterdev/videos)
- [medium](https://medium.com/)
- [Twitter](https://twitter.com/)
  - [flutterdevs](https://twitter.com/flutterdevs)
  - [r_FlutterDev](https://twitter.com/r_FlutterDev)
  - [FlutterWk](https://twitter.com/FlutterWk)
  - [Flutter](https://twitter.com/FlutterDev)

# State-Management

Es gibt eine ganze Reihe von flutter-Packages die das State-Management (vor allem Widget übergreifend) vereinfachen wollen. Diese haben ihre Stärken
und Schwächen, am Ende sollte man das wählen, was einem am besten von der Hand geht.
Es gibt z.B.

- [getx](https://pub.dev/packages/get)

Ein großes Bundle, aus (Reaktiven) State-Management mit eigenem Life-Cycle, Routing, Responive-Widgets, Translations und Utility-Methoden

- [provider](https://pub.dev/packages/provider)

Baut auf den flutter-Features InheritedWidget und ChangeNotifier auf und wird direkt in den Widget-Tree integriert, hat daher eine gute Lernkurve,
wenn dass das erste State-Framework ist

- [riverpod](https://pub.dev/packages/riverpod)
- [flutter_mobx](https://pub.dev/packages/flutter_mobx)
- [flutter_bloc](https://pub.dev/packages/flutter_bloc)

Hat aus meiner Sicht die größte Einstiegshürde, da es das komplexeste Framework. Für kleine Anwendungen finde ich BloC zu oversized, aber bei mittleren
und vor allem großem Anwendungen kann sich dieses Framework aber echt bezahlt machen.

# Navigation

Auch hier bietet die Community einige gute Packages, um die flutter-Navigator-Api zu kapseln und für die meisten Anwendungsfälle findet man hier auch
ein Package mit dem man seine Navigation händeln kann.

- [getx](https://pub.dev/packages/get)

Die Navigation von GetX kann zum einen direkt mit dem Life-Cycle-Handling aus dem State-Management kombiniert werden, erlaubt aber über ein Middelware-Konzept
auch die Integration von anderen Frameworks

- [go_router](https://pub.dev/packages/go_router)
- [auto_route](https://pub.dev/packages/auto_route)
- [beamer](https://pub.dev/packages/beamer)
- [fluro](https://pub.dev/packages/fluro)
- [vrouter](https://pub.dev/packages/vrouter)

# CI/CD

- [cirrus-ci](https://cirrus-ci.org/) Kostenlos für öffentlich github-Repos
  - [docker: cirrusci/flutter](https://hub.docker.com/r/cirrusci/flutter) Stellt docker-Images mit dem flutter-SDK zur Verfügung
- [bitrise](https://www.bitrise.io/) Für Privat mit monatlichen Limits kostenlos
- [codemagic](https://codemagic.io/start/) Für Privat mit monatlichen Limits kostenlos
  - Bietet eigenes Deployment für PWA an
  - Hat gute Integration mit firebase
- [firebase](https://firebase.google.com/) Bietet auch in der kostenlosen Variante sehr viele Funktionen an
  - Hosting der PWA
  - Analytics
  - Crashreports (nicht PWA)
  - Test Lab (monatliches Limit)
  - User-Management (monatliches Limit)
  - Cloud-Storage, Database, Realtime-Database (monatliches Limit)
  - Remote-Config
  - In-App-Messaging, Cloud Messaging