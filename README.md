
# Learn Swift SD
# Basics of the Realm Database

The way that we've chosen to install the Realm Database into this project is 
with **Cocoa Pods**, which is a third party depency manager. For more info 
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
the *fileName.xcworkspace*. You can desregaurd the *fileName.xcodeproj*.
It's a good idea to build the project just to make sure that everthing is
running properly and Xcode is recognizing the newly installed frameworks.
Now it's time to **Have Fun!**






