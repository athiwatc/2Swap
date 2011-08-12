//
//  JoyLayer.m
//  2Swap
//
//  Created by Wairung Tiranalinvit on 8/12/54 BE.
//  Copyright 2554 Kasetsart University. All rights reserved.
//

#import "JoyLayer.h"
#import "SneakyJoystick.h"
#import "SneakyJoystickSkinnedJoystickExample.h"
#import "SneakyJoystickSkinnedDPadExample.h"
#import "SneakyButton.h"
#import "SneakyButtonSkinnedBase.h"
#import "ColoredCircleSprite.h"

@implementation JoyLayer

+(id) scene
{
    CCScene *scene = [CCScene node];
    JoyLayer *layer = [JoyLayer node];
    [scene addChild:layer];
    return scene;
}

-(id) init
{
    if( (self = [super init])) {
        
		SneakyJoystickSkinnedBase *leftJoy = [[[SneakyJoystickSkinnedBase alloc] init] autorelease];
		leftJoy.position = ccp(40,36);
		leftJoy.backgroundSprite = [ColoredCircleSprite circleWithColor:ccc4(255, 0, 0, 128) radius:36];
		leftJoy.thumbSprite = [ColoredCircleSprite circleWithColor:ccc4(0, 0, 255, 200) radius:20];
		leftJoy.joystick = [[SneakyJoystick alloc] initWithRect:CGRectMake(0,0,128,128)];
		leftJoystick = [leftJoy.joystick retain];
		[self addChild:leftJoy];
		
		SneakyButtonSkinnedBase *rightJumpBut = [[[SneakyButtonSkinnedBase alloc] init] autorelease];
		rightJumpBut.position = ccp(455,64);
		rightJumpBut.defaultSprite = [ColoredCircleSprite circleWithColor:ccc4(0, 30, 128, 255) radius:25];
		rightJumpBut.activatedSprite = [ColoredCircleSprite circleWithColor:ccc4(255, 255, 255, 255) radius:25];
		rightJumpBut.pressSprite = [ColoredCircleSprite circleWithColor:ccc4(255, 0, 0, 255) radius:25];
		rightJumpBut.button = [[SneakyButton alloc] initWithRect:CGRectMake(0, 0, 64, 25)];
		jumpButton = [rightJumpBut.button retain];
		jumpButton.isToggleable = YES;
		[self addChild:rightJumpBut];
        
        
        SneakyButtonSkinnedBase *rightSwapBut = [[[SneakyButtonSkinnedBase alloc] init] autorelease];
		rightSwapBut.position = ccp(400,32);
		rightSwapBut.defaultSprite = [ColoredCircleSprite circleWithColor:ccc4(128, 0, 94, 255) radius:25];
		rightSwapBut.activatedSprite = [ColoredCircleSprite circleWithColor:ccc4(255, 255, 255, 255) radius:25];
		rightSwapBut.pressSprite = [ColoredCircleSprite circleWithColor:ccc4(255, 0, 0, 255) radius:25];
		rightSwapBut.button = [[SneakyButton alloc] initWithRect:CGRectMake(0, 0, 64, 25)];
		swapButton = [rightSwapBut.button retain];
		swapButton.isToggleable = YES;
        
		[self addChild:rightSwapBut];
    }
    return self;
}

-(void) dealloc {
    [super dealloc];
}
@end
