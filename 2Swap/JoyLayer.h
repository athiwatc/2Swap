//
//  JoyLayer.h
//  2Swap
//
//  Created by Wairung Tiranalinvit on 8/12/54 BE.
//  Copyright 2554 Kasetsart University. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@class SneakyJoystick;
@class SneakyButton;


@interface JoyLayer : CCLayer {
    SneakyJoystick *leftJoystick;
    SneakyButton *jumpButton;
    SneakyButton *swapButton;
}

+(id) scene;

@end
