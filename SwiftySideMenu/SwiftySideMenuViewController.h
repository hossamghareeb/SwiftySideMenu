//
//  ViewController.h
//  SwiftySideMenu
//
//  Created by Hossam Ghareeb on 8/6/15.
//  Copyright (c) 2015 Hossam Ghareeb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <pop/POP.h>
#import <POP/POPLayerExtras.h>


typedef enum {
    SwiftyMenuSideCenter,
    SwiftyMenuSideLeft
}SwiftyMenuSide;



@interface SwiftySideMenuViewController : UIViewController

/*!
 * @brief Setting the left view controller. Everytime you set this property, the previous left view will be removed from screen. The center view is always above left view
 */
@property (nonatomic, strong) UIViewController *leftViewController;

/*!
 * @brief Setting the center view controller. Everytime you set this property, the previous center view will be removed from screen. The center view is always above left view
 */
@property (nonatomic, strong) UIViewController *centerViewController;

/*!
 * @brief Set the delegate if you wanna be notified with animation did start/end for each view (center or left).
 * @see SwiftySideMenuViewControllerDelegate
 */
@property (nonatomic, weak) id delegate;

/*!
    * @brief When you trigger the left view. The center view is scalled and transitioned X value. This property changes the end scale value of center view. Default is 0.6
    */
@property (nonatomic, assign) float centerEndScale;


/*!
 * @brief The effective bounciness for left view animation. Use in conjunction with 'leftSpringAnimationSpeed' to change animation effect. Default value is 8.0
 */
@property (nonatomic, assign) float leftSpringAnimationBounciness;
/*!
 * @brief The effective speed for left view animation. Use in conjunction with 'leftSpringAnimationBounciness' to change animation effect. Default value is 10.0
 */
@property (nonatomic, assign) float leftSpringAnimationSpeed;
/*!
 * @brief The effective bounciness for center view animation. Use in conjunction with 'centerSpringAnimationSpeed' to change animation effect. Default value is 5.0
 */
@property (nonatomic, assign) float centerSpringAnimationBounciness;
/*!
 * @brief The effective speed for center view animation. Use in conjunction with 'centerSpringAnimationBounciness' to change animation effect. Default value is 10.0
 */
@property (nonatomic, assign) float centerSpringAnimationSpeed;

/*!
 * @brief enable or disable the left swipe gesture. The left swipe gesture will toggle the side menu if the left side is opened. Default value is YES
 */
@property (nonatomic, assign) BOOL enableLeftSwipeGesture;

/*!
 * @brief enable or disable the right swipe gesture. The right swipe gesture will toggle the side menu if the left side is NOT opened. Default value is YES
 */
@property (nonatomic, assign) BOOL enableRightSwipeGesture;

/*!
* @discussion toggle the left side menu. If its opened it will be closed and vice versa.
*/
-(void)toggleSideMenu;


/*!
* @discussion Determine whether the left menu is opened or not
* @return Yes if Left view is opened, NO otherwise
*/
-(BOOL)isLeftMenuOpened;

@end

/*!
 * @discussion SideMenu protocol for animation starts or ends for each side (Left and Center)
 */

@protocol SwiftySideMenuViewControllerDelegate <NSObject>
@optional
/*!
 @discussion
 SwiftySideMenu animation did start in one of its sides.
 @param sideMenuController
  The SwiftySideMenuControlle instance
 @param side
 The menu side that animation has started into.
 @see SwiftyMenuSide
 */
-(void)swiftSideMenu:(SwiftySideMenuViewController *)sideMenuController animationDidStartInSide:(SwiftyMenuSide)side;
/*!
 @discussion
 SwiftySideMenu animation did finish in one of its sides.
 @param sideMenuController
 The SwiftySideMenuControlle instance
 @param side
 The menu side that animation has ended into.
 @see SwiftyMenuSide
 @param finished
 indicated whether the animation has finished properly or not.
 */
-(void)swiftSideMenu:(SwiftySideMenuViewController *)sideMenuController animationDidFinishInSide:(SwiftyMenuSide)side finished:(BOOL)finished;
@end
