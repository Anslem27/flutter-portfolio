# Anslem.io developer portfolio website

### Personal developer portfolio WebApp wih [Flutter](https://flutter.dev)

<img src="doc/show_case.png" alt="ShowCase Image">

**Note**

- Running with html renderer runs with multiple errors.
- MobileView may still have afew responsive issues.

#### Running Locally

```
# Fetch packages
flutter pub get

# Run app on chrome
flutter run -d chrome --web-renderer canvaskit

# Build for deployment
flutter build web --web-renderer canvaskit
```

## Stack and Tools

- [Flutter](https://flutter.dev/) - A Dart framework for cross-platform development.
- [Responsive Framework](https://pub.dev/packages/responsive_framework) - A simple and easy to use responsive framework for flutter apps.

<a href="https://github.com/Codelessly/ResponsiveFramework">
  <img alt="Built Responsive"
       src="https://raw.githubusercontent.com/Codelessly/ResponsiveFramework/master/packages/Built%20Responsive%20Badge.png"/>
</a>

## Project structure

```
$PROJECT_ROOT
│   # App Animations
├── lib/animations/
│   # Data
├── lib/data/
│   # Models
├── lib/models/
│   # Pages
├── lib/pages/
│   # Screen View
├── lib/screens/
│   # Services
├── lib/services/
│   # Theme
├── lib/theme/
│   # Utils
├── lib/utils/
│   # Widgets
|__ lib/widgets/
```

### MIT License.

You can create your own portfolio for free without notifying me by forking this project under the following condition:

- Add a link to this project.

### **WebSite View Count**

<a href="https://hits.seeyoufarm.com"><img src="https://hits.seeyoufarm.com/api/count/incr/badge.svg?url=https%3A%2F%2Fanslem27.github.io&count_bg=%23BB1313&title_bg=%23000000&icon=flutter.svg&icon_color=%235785DD&title=Viewer+Count&edge_flat=false"/></a>

<p align="center"> **Contributions highly needed and appreciated.** </p>
