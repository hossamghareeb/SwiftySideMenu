//
//  UIViewController+SwiftySideMenu.h
//  SwiftySideMenu
//
//  Created by Hossam Ghareeb on 8/14/15.
//  Copyright © 2015 Hossam Ghareeb. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SwiftySideMenuViewController.h"



@interface UIViewController (SwiftySideMenu)

/*!
 * @brief The SwiftySideMenuViewController that the view controller is contained within. If the view controller is not contained within a SwiftySideMenuViewController, this property is nil. Note that if the view controller is contained within a UINavigationController, that navigation controller is contained within a SwiftySideMenuViewController, this property will return a refernce to the SwiftySideMenuViewController, despite the fact that it is not the direct parent of the view controller.
 */
@property (nonatomic, weak, readonly) SwiftySideMenuViewController *swiftySideMenu;

@end
