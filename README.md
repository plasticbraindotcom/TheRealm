
# Learn Swift SD
# Basics of the Realm Database

---
This is a dependency manager neutral fork of [The Realm](https://github.com/LearnSwiftSD/TheRealm) project authored by [Stephen Martinez](https://github.com/enuance).

To link to the Realm framework utilized in this project, you have several options:
* Use CocoaPods. Pros: easiest and fastest to setup. Cons: Alters your project and requires you to use a workspace.
* Use Carthage. Pros: Simple; doesn't alter your project or require a workspace. Cons: Requires additional manual setup.
* Manually download, compile, link to the Realm framework yourself.

---

### Use CocoaPods Method

**Cocoa Pods** is a third party depency manager. For more info 
on Cocoa Pods feel free to check out their [web page](https://cocoapods.org).  To install CocoaPods go to your terminal and enter:

```
userName$ sudo gem install cocoapods
```

For this project I've already written what's called a **Podfile**, but usually
you'd have to do this step yourself. That being said this step is not
needed for this project, but just incase you'd like to use CocoaPods for
future projects you would go back to your terminal and enter:

```
# Navigate to the project directory
userName$ cd /Users/YourUserName/ProjectLocation

# Create the Podfile at that location
userName$ pod init

# Open the file to configure
userName$ sudo nano Podfile
```

For instruction on configuring a Podfile check out the *Get Started* section
of their [web page](https://cocoapods.org). Again, you won't need to do that for this
project. Next step is to install the pods that are listed in the Podfile by entering:

```
userName$ pod install
```

Once that is executed it will install your specified frameworks and plop the
project into a workspace. From this point on you'll need to do your work in
the *fileName.xcworkspace*. You can disregard the *fileName.xcodeproj*.
It's a good idea to build the project just to make sure that everthing is
running properly and Xcode is recognizing the newly installed frameworks.

---

### Use Carthage Method

[Carthage](https://github.com/Carthage/Carthage) is a "simple, decentralized dependency manager" you can use in your Swift projects. There is a [nice tutorial on Carthage](https://www.raywenderlich.com/165660/carthage-tutorial-getting-started-2) if you wish to look at it in further detail.

To install Carthage you can use a Terminal option like Homebrew, or you can install using the latest installer package found on the [Carthage releases page](https://github.com/Carthage/Carthage/releases). NOTE: The packages are typically not codesigned properly and will require extra permissions to run. After trying to run the pkg file if you get such a warning, you will need to go to System Preferences > Security & Privacy and select the open anyways option to run it.

Like CocoaPods, Carthage relies upon a configuration file placed in the project root to perform its work. This special Cartfile has already been created for you in this version of the project

To obtain the Realm frameworks, in Terminal enter:

```
# Navigate to the project directory
userName$ cd /Users/YourUserName/ProjectLocation/ColorFav

# Download and compile if necessary the Realm frameworks for iOS
carthage update --platform iOS
```

When this is complete, a Carthage folder will be added to your project, with various framework builds nested within. These Realm frameworks must be manually linked to your project target.

Open the `ColorFav.xcodeproj` file in Xcode. In the Project Navigator, select ColorFav to see your project settings. Select ColorFav from the TARGETS list. Choose the General tab at the top, and scroll down to the Linked Frameworks and Libraries section.

With this window open in Xcode, open the project Carthage folder in the Finder and navigate to the Build/iOS folder. Select both the Realm.framework and RealmSwift.framework files, and drag them into your Xcode Linked Frameworks and Libraries section.

Your Realm framework has now been setup and linked! However you may find that you have to perform one additional step, as outlined in [the tutorial](https://www.raywenderlich.com/165660/carthage-tutorial-getting-started-2) referenced above:

In the same Xcode target setup window, switch to Build Phases and add a new Run Script build phase by clicking the + in the top left. Add the following command:

`/usr/local/bin/carthage copy-frameworks`

Click the + under Input Files and add an entry for each framework:

`(SRCROOT)/Carthage/Build/iOS/Realm.framework`
`(SRCROOT)/Carthage/Build/iOS/Realm.framework`

You can now begin coding in Xcode, opening the *ColorFav.xcodeproj* as usual.

---

### Manually linking to the Realm frameworks

This is beyond the scope of this project. Good luck, pioneer!

---

*Now* it's time to **Have Fun!**






