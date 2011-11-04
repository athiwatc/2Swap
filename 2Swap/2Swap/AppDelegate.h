//
//  AppDelegate.h
//  2Swap
//
//  Created by Wairung Tiranalinvit on 11/4/54 BE.
//  Copyright __MyCompanyName__ 2554. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootViewController;

@interface AppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow			*window;
	RootViewController	*viewController;
}

@property (nonatomic, retain) UIWindow *window;

@end
