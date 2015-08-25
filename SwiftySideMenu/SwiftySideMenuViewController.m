//
//  ViewController.m
//  SwiftySideMenu
//
//  Created by Hossam Ghareeb on 8/6/15.
//  Copyright (c) 2015 Hossam Ghareeb. All rights reserved.
//

#import "SwiftySideMenuViewController.h"
#import "UIViewController+SwiftySideMenu.h"

#define kPopAnimationCenterKey @"popAnimationCenter"
#define kPopAnimationProgressCenterKey @"popAnimationProgressCenter"
#define kPopAnimationLeftKey @"popAnimationLeft"
#define kPopAnimationProgressLeftKey @"popAnimationProgressLeft"


@interface SwiftySideMenuViewController ()<POPAnimationDelegate, UIGestureRecognizerDelegate>
{
    BOOL toggled; // used for triggering the left view
}

//The animation progress values for center and left.
@property (nonatomic) CGFloat centerPopAnimationProgress;
@property (nonatomic) CGFloat leftPopAnimationProgress;

@property (nonatomic, strong) UISwipeGestureRecognizer *leftSwipeGesture;
@property (nonatomic, strong) UISwipeGestureRecognizer *rightSwipeGesture;

@end

@implementation SwiftySideMenuViewController

-(void)loadView{
    [super loadView];
    
    //The default value of scaling center view.
    self.centerEndScale = 0.6;
    
    self.centerSpringAnimationBounciness = 5;
    self.centerSpringAnimationSpeed = 10;
    self.leftSpringAnimationBounciness = 8;
    self.leftSpringAnimationSpeed = 10;
    
    self.enableLeftSwipeGesture = YES;
    self.enableRightSwipeGesture = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
}



#pragma mark - Swipe Gestures -

-(void)setEnableLeftSwipeGesture:(BOOL)enableLeftSwipeGesture{
    if (enableLeftSwipeGesture) {
        [self addLeftSwipeGesture];
    }
    else{
        if (self.leftSwipeGesture) {
            [self.view removeGestureRecognizer:self.leftSwipeGesture];
        }
        
    }
    
    _enableLeftSwipeGesture = enableLeftSwipeGesture;
}
-(void)setEnableRightSwipeGesture:(BOOL)enableRightSwipeGesture{
    if (enableRightSwipeGesture) {
        [self addRightSwipeGesture];
    }
    else{
        if (self.rightSwipeGesture) {
            [self.view removeGestureRecognizer:self.rightSwipeGesture];
        }
    }
    
    _enableRightSwipeGesture = enableRightSwipeGesture;
}

-(void)addLeftSwipeGesture{
    UISwipeGestureRecognizer *swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipeLeft:)];
    swipeGesture.direction = UISwipeGestureRecognizerDirectionLeft;
    swipeGesture.delegate = self;
    [self.view addGestureRecognizer:swipeGesture];
    self.leftSwipeGesture = swipeGesture;
}

-(void)addRightSwipeGesture{
    
    
    UISwipeGestureRecognizer *swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipeRight:)];
    swipeGesture.direction = UISwipeGestureRecognizerDirectionRight;
    swipeGesture.delegate = self;
    [self.view addGestureRecognizer:swipeGesture];
    self.rightSwipeGesture = swipeGesture;
}

-(void)didSwipeLeft:(UISwipeGestureRecognizer *)gesture{
    if ([self isLeftMenuOpened]) {
        [self toggleSideMenu];
    }
    
}
-(void)didSwipeRight:(UISwipeGestureRecognizer *)gesture{
    if (![self isLeftMenuOpened]) {
        [self toggleSideMenu];
    }
}

#pragma mark - Left & Center Views -

-(void)setLeftViewController:(UIViewController *)leftVC{
    
    if ([leftVC isEqual:self.leftViewController]) {
        return;
    }
    if (_leftViewController) {
        
        //We had a left view controller before!, so remove its view from super view
        [_leftViewController.view removeFromSuperview];
    }
    
    _leftViewController = leftVC;
    [self addChildViewController:leftVC];
    [self.view insertSubview:_leftViewController.view belowSubview:self.centerViewController.view];

}

-(BOOL)isLeftMenuOpened{
    return toggled;
}

-(void)setCenterViewController:(UIViewController *)centerVC{
    if ([centerVC isEqual:self.centerViewController]) {
        return;
    }
    if (_centerViewController) {
        
        [_centerViewController.view removeFromSuperview];
    }
    [self addChildViewController:centerVC];
    
    _centerViewController = centerVC;
    [self.view addSubview:_centerViewController.view];
}

-(void)toggleSideMenu
{
    [self toggleCenterPopAnimation:!toggled];
    [self togglePopAnimationLeft:!toggled];
    toggled = !toggled;

}

#pragma mark - Pop Animations -

- (void)toggleCenterPopAnimation:(BOOL)on {
    POPSpringAnimation *animation = [self.centerViewController pop_animationForKey:kPopAnimationCenterKey];
    
    if (!animation) {
        animation = [POPSpringAnimation animation];
        animation.name = kPopAnimationCenterKey;
        animation.delegate = self;
        animation.springBounciness = self.centerSpringAnimationBounciness;
        animation.springSpeed = self.centerSpringAnimationSpeed;
        animation.property = [POPAnimatableProperty propertyWithName:kPopAnimationProgressCenterKey initializer:^(POPMutableAnimatableProperty *prop) {
            prop.readBlock = ^(UIViewController *obj, CGFloat values[]) {
                values[0] = _centerPopAnimationProgress;
            };
            prop.writeBlock = ^(UIViewController *obj, const CGFloat values[]) {
                self.centerPopAnimationProgress = values[0];
            };
            prop.threshold = 0.001;
        }];
        
        [self.centerViewController pop_addAnimation:animation forKey:kPopAnimationCenterKey];
    }
    
    animation.toValue = on ? @(1.0) : @(0.0);
}
-(void)setCenterPopAnimationProgress:(CGFloat)progress{
    
    _centerPopAnimationProgress = progress;
    
    CGFloat transition = POPTransition(progress, 1, self.centerEndScale);
    POPLayerSetScaleXY(self.centerViewController.view.layer, CGPointMake(transition, transition));
    
    CGFloat transition2 = POPTransition(progress, 0, 400);
    POPLayerSetTranslationX(self.centerViewController.view.layer, POPPixelsToPoints(transition2));
}


- (void)togglePopAnimationLeft:(BOOL)on {
    POPSpringAnimation *animation = [self.leftViewController pop_animationForKey:kPopAnimationLeftKey];
    
    if (!animation) {
        animation = [POPSpringAnimation animation];
        animation.name = kPopAnimationLeftKey;
        animation.delegate = self;
        animation.springBounciness = self.leftSpringAnimationBounciness;
        animation.springSpeed = self.leftSpringAnimationSpeed;
        animation.property = [POPAnimatableProperty propertyWithName:kPopAnimationProgressLeftKey initializer:^(POPMutableAnimatableProperty *prop) {
            prop.readBlock = ^(UIViewController *obj, CGFloat values[]) {
                values[0] = self.leftPopAnimationProgress;
            };
            prop.writeBlock = ^(UIViewController *obj, const CGFloat values[]) {
                self.leftPopAnimationProgress = values[0];
            };
            prop.threshold = 0.001;
        }];
        
        [self.leftViewController pop_addAnimation:animation forKey:kPopAnimationLeftKey];
    }
    
    animation.toValue = on ? @(1.0) : @(0.0);
}

-(void)setLeftPopAnimationProgress:(CGFloat)progress{
    _leftPopAnimationProgress = progress;
    
    CGFloat transition2 = POPTransition(progress, -645, 0);
    POPLayerSetTranslationX(self.leftViewController.view.layer, POPPixelsToPoints(transition2));
}



static inline CGFloat POPTransition(CGFloat progress, CGFloat startValue, CGFloat endValue) {
    return startValue + (progress * (endValue - startValue));
}

static inline CGFloat POPPixelsToPoints(CGFloat pixels) {
    static CGFloat scale = -1;
    if (scale < 0) {
        scale = [UIScreen mainScreen].scale;
    }
    return pixels / scale;
}

#pragma mark - Animation Delegate -
-(SwiftyMenuSide)getSideOfAnimation:(POPAnimation *)anim{
    
    SwiftyMenuSide side = SwiftyMenuSideLeft;
    if ([anim.name isEqualToString:kPopAnimationCenterKey]) {
        side = SwiftyMenuSideCenter;
    }
    
    return side;
}
- (void)pop_animationDidStart:(POPAnimation *)anim{
    
    SwiftyMenuSide side = [self getSideOfAnimation:anim];
    NSLog(@"animation %@ did start in %d", anim.name, side);
    
    if ([self.delegate respondsToSelector:@selector(swiftSideMenu:animationDidStartInSide:)]) {
        
        [self.delegate swiftSideMenu:self animationDidStartInSide:side];
    }
    
}

- (void)pop_animationDidStop:(POPAnimation *)anim finished:(BOOL)finished{
    SwiftyMenuSide side = [self getSideOfAnimation:anim];
        NSLog(@"animation %@ did finish in %d", anim.name, side);
    if ([self.delegate respondsToSelector:@selector(swiftSideMenu:animationDidFinishInSide:finished:)]) {
        
        [self.delegate swiftSideMenu:self animationDidFinishInSide:side finished:finished];
    }
    
    
}

#pragma mark - UIGestureDelegate -

// called when the recognition of one of gestureRecognizer or otherGestureRecognizer would be blocked by the other
// return YES to allow both to recognize simultaneously. the default implementation returns NO (by default no two gestures can be recognized simultaneously)
//
// note: returning YES is guaranteed to allow simultaneous recognition. returning NO is not guaranteed to prevent simultaneous recognition, as the other gesture's delegate may return YES
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

// called once per attempt to recognize, so failure requirements can be determined lazily and may be set up between recognizers across view hierarchies
// return YES to set up a dynamic failure requirement between gestureRecognizer and otherGestureRecognizer
//
// note: returning YES is guaranteed to set up the failure requirement. returning NO does not guarantee that there will not be a failure requirement as the other gesture's counterpart delegate or subclass methods may return YES
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRequireFailureOfGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer NS_AVAILABLE_IOS(7_0)
{
    return NO;
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer NS_AVAILABLE_IOS(7_0)
{
    return NO;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
