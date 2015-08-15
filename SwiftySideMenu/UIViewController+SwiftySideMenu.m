//
//  UIViewController+SwiftySideMenu.m
//  SwiftySideMenu
//
//  Created by Hossam Ghareeb on 8/14/15.
//  Copyright © 2015 Hossam Ghareeb. All rights reserved.
//

#import "UIViewController+SwiftySideMenu.h"

@implementation UIViewController (SwiftySideMenu)

-(SwiftySideMenuViewController * __nullable)swiftySideMenu{
    
    UIViewController *parentViewController = self.parentViewController;
    while (parentViewController != nil) {
        if([parentViewController isKindOfClass:[SwiftySideMenuViewController class]]){
            return (SwiftySideMenuViewController *)parentViewController;
        }
        parentViewController = parentViewController.parentViewController;
    }
    return nil;
}


@end
