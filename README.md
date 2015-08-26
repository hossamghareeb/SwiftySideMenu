# SwiftySideMenu

`SwiftySideMenu` is a lightweight, fully customizable, and easy to use controller to add left menu and center view controllers with scale animation based on Pop framework. `SwiftySideMenu` animations are built using [Pop](https://github.com/facebook/pop) framework to provide smooth and awesome spring animations. `SwiftySideMenu` is written in `Objective-C` and its very easy to use with `Swift` projects. The demo itself is based on `Swift` to see how easy its used with in `Swift`.

<p align="center"><img src ="https://github.com/hossamghareeb/SwiftySideMenu/blob/master/Demo/demo.gif?raw=true"/></p>

## Installation

First you have to install Pop. Pop is available on [CocoaPods](http://cocoapods.org). Just add the following to your project Podfile:

```ruby
pod 'pop', '~> 1.0'
```
Then, Add the [SwiftySideMenu library files](https://github.com/hossamghareeb/SwiftySideMenu/tree/master/SwiftySideMenu) to your project:
* SwiftySideMenuViewController.h
* SwiftySideMenuViewController.m
* UIViewController+SwiftySideMenu.h
* UIViewController+SwiftySideMenu.m

## Usage
`SwiftySideMenu` is very easy to use. After adding the Pop framework and the library files, import the needed files as below:

```objective-c
#import "SwiftySideMenuViewController.h"
#import "UIViewController+SwiftySideMenu.h"
```
Incase of your project is Swift based, just add the import statements in the briding header file.

> Don't have briding header file? Add a header file to your project, named [MyProjectName]-Bridging-Header.h to import any Objective-C code you want your Swift code to have access to. Then In your project build settings, go to Swift Compiler – Code Generation, and next to Objective-C Bridging Header add the path to your bridging header file, from the project’s root folder. So it could by MyProject/MyProject-Bridging-Header.h or simply MyProject-Bridging-Header.h if the file lives in the project root folder.


### SwiftSideMenuViewController

`SwiftySideMenuViewController` is the main view controller that will be the root view controller in your project. You can set it as the root view controller from Storyboard or programmatically. 


### Setting Left and Center view controllers

In `SwiftySideMenuViewController` you use the properties `centerViewController` and `leftViewController` to set the left and center view controllers anytime. Check example:

```Swift
let swiftySideMenuVC = self.window?.rootViewController as! SwiftySideMenuViewController

let centerVC = swiftySideMenuVC.storyboard?.instantiateViewControllerWithIdentifier("Center")        
let leftVC = swiftySideMenuVC.storyboard?.instantiateViewControllerWithIdentifier("Left")
        
swiftySideMenuVC.centerViewController = centerVC
swiftySideMenuVC.leftViewController = leftVC
```

### Accessing the SwiftySideMenuViewController

`SwiftySideMenuViewController` instance can be accessed easily from left or center view controller by calling the property `.swiftySideMenu` in any UIViewController thanks to the category `UIViewController+SwiftySideMenu`.
> Even if the center view controller is `UINavigationController` or `UITabBarController`. You can still access the `SwiftySideMenuViewController` from children view controllers.

In the demo project, the center view controller is embeded in `UINavigationController` and to toggle the side menu when the left navigation bar button is clicked, we do the following:

```Swift

    @IBAction func toggleSideMenu(sender: AnyObject) {
        self.swiftySideMenu?.toggleSideMenu()
    }

```


### Customizing The Animations Of Left & Center View Controllers

You can customize the final value of scale animation of the center view controller. As well for the center and left view controller you can customize the bounciness and speed of their animations.

```Swift

swiftySideMenuVC.centerEndScale = 0.4
swiftySideMenuVC.leftSpringAnimationSpeed = 20

```
### Toggling Side Menu

You can easily toggle (open or close) the side menu by calling the function `toggleSideMenu` in `SwiftySideMenuViewController`

```Swift

swiftySideMenuVC.toggleSideMenu()

```

Side menu also can be toggled using swipe gestures. Swiping right will open the side menu if it was closed. Swiping left will close the side menu if it was opened. Swipe gestures are enabled by default, if you want to disable any gesture do the following:

```Swift

swiftySideMenuVC.enableLeftSwipeGesture = false // disable the left swipe gesture

swiftySideMenuVC.enableRightSwipeGesture = false // disable the right swipe gesture

```
### Setting Up The Delegate

You can set the delegate in `SwiftySideMenuViewController` to be notified when the animations start and finish. You will find two method in the delegate to be used:

```objective-c
-(void)swiftSideMenu:(SwiftySideMenuViewController *)sideMenuController animationDidStartInSide:(SwiftyMenuSide)side;

-(void)swiftSideMenu:(SwiftySideMenuViewController *)sideMenuController animationDidFinishInSide:(SwiftyMenuSide)side finished:(BOOL)finished;
```

`SwiftyMenuSide` is an enum with two values `SwiftyMenuSideCenter` and `SwiftyMenuSideLeft`.


# License

The MIT License (MIT)

**Copyright (c) 2015 Hossam Ghareeb (hossam.ghareb@gmail.com)**

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
