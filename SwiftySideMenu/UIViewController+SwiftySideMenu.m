//
//  UIViewController+SwiftySideMenu.m
//  SwiftySideMenu
//
//  Created by Hossam Ghareeb on 8/14/15.
//  Copyright © 2015 Hossam Ghareeb. All rights reserved.
//

#import "UIViewController+SwiftySideMenu.h"

#import <objc/runtime.h>

static void * SwiftySideMenuPropertyKey = &SwiftySideMenuPropertyKey;

@implementation UIViewController (SwiftySideMenu)

-(SwiftySideMenuViewController * __nullable)swiftySideMenu{
    
    return objc_getAssociatedObject(self, SwiftySideMenuPropertyKey);
}

-(void)setSwiftySideMenu:(SwiftySideMenuViewController * __nullable)swiftySideMenu{
    
    objc_setAssociatedObject(self, SwiftySideMenuPropertyKey, swiftySideMenu, OBJC_ASSOCIATION_ASSIGN);
    //Assign to avoid Retain Cycle
    // MasterDetailsVC is already the root view controller and don't need to be retained. Left and Center view controller are already retained in initialization.
}


@end
