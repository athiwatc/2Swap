//
//  AppDelegate.h
//  2Swap
//
//  Created by Athiwat Chunlakhan on 7/4/11.
//  Copyright Kasetsart University 2011. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootViewController;

@interface AppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow			*window;
	RootViewController	*viewController;
}

@property (nonatomic, retain) UIWindow *window;

@end