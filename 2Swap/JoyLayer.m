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
		
		SneakyButtonSkinnedBase *jumpBut = [[[SneakyButtonSkinnedBase alloc] init] autorelease];
		jumpBut.position = ccp(455,64);
		jumpBut.defaultSprite = [ColoredCircleSprite circleWithColor:ccc4(0, 30, 128, 255) radius:25];
		jumpBut.activatedSprite = [ColoredCircleSprite circleWithColor:ccc4(255, 255, 255, 255) radius:25];
		jumpBut.pressSprite = [ColoredCircleSprite circleWithColor:ccc4(255, 0, 0, 255) radius:25];
		jumpBut.button = [[SneakyButton alloc] initWithRect:CGRectMake(0, 0, 64, 25)];
		jumpButton = [jumpBut.button retain];
		[self addChild:jumpBut];
        
        
        SneakyButtonSkinnedBase *swapBut = [[[SneakyButtonSkinnedBase alloc] init] autorelease];
		swapBut.position = ccp(400,32);
		swapBut.defaultSprite = [ColoredCircleSprite circleWithColor:ccc4(128, 0, 94, 255) radius:25];
		swapBut.activatedSprite = [ColoredCircleSprite circleWithColor:ccc4(255, 255, 255, 255) radius:25];
		swapBut.pressSprite = [ColoredCircleSprite circleWithColor:ccc4(255, 0, 0, 255) radius:25];
		swapBut.button = [[SneakyButton alloc] initWithRect:CGRectMake(0, 0, 64, 25)];
		swapButton = [swapBut.button retain];
        
		[self addChild:swapBut];
        [self scheduleUpdate];
    }
    return self;
}

-(void) update:(ccTime)delta
{
	totalTime += delta;
    
	//Swap Action
	if (swapButton.active && totalTime > nextSwapTime)
	{
		nextSwapTime = totalTime + 1.0f;
        
	}
    
    if (jumpButton.active && totalTime > nextJumpTime)
	{
		nextSwapTime = totalTime + 1.0f;
	}

	
	// Allow faster shooting by quickly tapping the fire button.
	if (swapButton.active == NO)
	{
		nextSwapTime = 0;
	}
    
    if (jumpButton.active == NO) {
        nextJumpTime = 0;
    }
    
	// Moving the ship with the thumbstick.
	/*GameScene* game = [GameScene sharedGameScene];
	Ship* ship = [game defaultShip];
	
	CGPoint velocity = ccpMult(joystick.velocity, 200);
	if (velocity.x != 0 && velocity.y != 0)
	{
		ship.position = CGPointMake(ship.position.x + velocity.x * delta, ship.position.y + velocity.y * delta);
	}*/
}

-(void) dealloc {
    [super dealloc];
}
@end
