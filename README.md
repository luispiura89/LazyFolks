# LazyFolks

Welcome to LazyFolks! This is app that helps you to find something to do when you are bored 🥳

| Search Screen | Details Screen | Search Error |
| :------------ |:---------------| :-----|
| <img width=375 alt="" src="https://github.com/luispiura89/LazyFolks/blob/read-me-file-changes/Resources/SearchScreen.png"> | <img width=375 alt="" src="https://github.com/luispiura89/LazyFolks/blob/read-me-file-changes/Resources/DetailsScreen.png"> | <img width=375 alt="" src="https://github.com/luispiura89/LazyFolks/blob/read-me-file-changes/Resources/SearchScreenWithError.png"> |

Tools
-------------
This application was built using `XCode 13.1` and `Swift 5.5`. The application deployment target is iOS 15.

Instructions
-------------

Open the `LazyFolksWorkspace` in the root folder to launch the project. The workspace contains two projects: `LazyFolksEngine` and `LazyFolksiOSApp`. 
The `LazyFolksEngine` project has two schemes the namesake one which contains all the platform agnostic logic, it includes presentation logic and domain components and the second one `LazyFolksiOS`, which contains all the iOS specific components such as views and view controllers..

<img width=600 alt="" src="https://github.com/luispiura89/LazyFolks/blob/read-me-file-changes/Resources/WorkspaceDiagram.png">

Running the app
-------------

Select the `LazyFolksiOSApp` scheme to run the application.

Architecture
-------------

This project is built using Unidirectional MVP. The view controllers speak with abstractions that could be either protocols or closures, this abstractions decouple the view controllers from core components such as loaders or models. The abstractions can interact with core components and notify the views through presenters. The view controllers are also agnostic agnostic from the presenters. 

<img width=600 alt="" src="https://github.com/luispiura89/LazyFolks/blob/read-me-file-changes/Resources/UnidirectionalMVP.png">

The `LazyFolksiOSApp` scheme also acts as the composition root of the application. Here we adapt and inject the required dependencies, this is the only place where modules can be integrated. 

Testing
-------------

Each scheme has a testing target. Please select the `iPhone 13 iOS 15` to test the `LazyFolksiOS` scheme.  

