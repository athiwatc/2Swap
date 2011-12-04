//
//  Player.h
//  SimpleBox2dScroller
//
//  Created by min on 3/17/11.
//  Copyright 2011 Min Kwon. All rights reserved.
//

#import "cocos2d.h"
#import "Box2D.h"
#import "GameCharacter.h"
#import "SneakyButton.h"
#import "SneakyJoystick.h"

@interface Player : GameCharacter {
    b2Body          *body;
    SneakyJoystick *joystick;
    SneakyButton *jumpButton ;
    SneakyButton *attackButton;
}

-(void) createBox2dObject:(b2World*)world;
-(void) jump;
-(void) moveRight;
-(void) moveLeft;
-(void) updateStateWithDeltaTime:(ccTime)deltaTime;

@property (nonatomic, readwrite) b2Body *body;
@property (nonatomic,assign) SneakyJoystick *joystick;
@property (nonatomic,assign) SneakyButton *jumpButton;
@property (nonatomic,assign) SneakyButton *attackButton;

@end
