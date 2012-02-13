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
#import "ContactListener.h"

@interface Player : GameCharacter {
    b2Body *body;
    b2Fixture* bodyFixture;
    BOOL isSwapRed;
    CCSpriteFrame *standingFrame;
    
    // Standing, breathing, and walking
    CCAnimation *breathingAnim;
    CCAnimation *breathingRedAnim;
    CCAnimation *walkingAnim;
    CCAnimation *walkingRedAnim;
    
    // Crouching, standing up, and Jumping
    CCAnimation *crouchingAnim;
    CCAnimation *crouchingRedAnim;
    CCAnimation *standingUpAnim;
    CCAnimation *standingUpRedAnim;
    CCAnimation *jumpingAnim;
    CCAnimation *jumpingRedAnim;
    CCAnimation *afterJumpingAnim;
    CCAnimation *afterJumpingRedAnim;
        
    // Taking Damage, win, and Death
    CCAnimation *deathAnim;
    CCAnimation *deathRedAnim;
    CCAnimation *winAnim;    
    CCAnimation *winRedAnim;
    
    CCAnimation *explodedAnim;


    // JoyStick
    SneakyJoystick *joystick;
    SneakyButton *jumpButton ;
    SneakyButton *attackButton;
    
    float millisecondsStayingIdle;
    
    ContactListener *contactListener;
    BOOL jumpButtonActived;

    float lastYVelocity;
	float jumpCounter;
    bool onGround;
}

-(void) createBox2dObject:(b2World*)world;
-(void) createPlayerFixtureDef : (int) stateTag;
-(void) move : (float) x;
-(void) jump;
-(void) updateStateWithDeltaTime:(ccTime)deltaTime;

@property (nonatomic, readwrite) b2Body *body;
// Standing, breathing, and walking
@property (nonatomic, retain) CCAnimation *breathingAnim;
@property (nonatomic, retain) CCAnimation *breathingRedAnim;
@property (nonatomic, retain) CCAnimation *walkingAnim;
@property (nonatomic, retain) CCAnimation *walkingRedAnim;

// Crouching, standing up, and Jumping
@property (nonatomic, retain) CCAnimation *crouchingAnim;
@property (nonatomic, retain) CCAnimation *crouchingRedAnim;
@property (nonatomic, retain) CCAnimation *standingUpAnim;
@property (nonatomic, retain) CCAnimation *standingUpRedAnim;
@property (nonatomic, retain) CCAnimation *jumpingAnim;
@property (nonatomic, retain) CCAnimation *jumpingRedAnim;
@property (nonatomic, retain) CCAnimation *afterJumpingAnim;
@property (nonatomic, retain) CCAnimation *afterJumpingRedAnim;

// Taking Damage and Death
@property (nonatomic, retain) CCAnimation *deathAnim;
@property (nonatomic, retain) CCAnimation *deathRedAnim;
@property (nonatomic, retain) CCAnimation *winAnim;
@property (nonatomic, retain) CCAnimation *winRedAnim;

@property (nonatomic, retain) CCAnimation *explodedAnim;

@property (nonatomic,assign) SneakyJoystick *joystick;
@property (nonatomic,assign) SneakyButton *jumpButton;
@property (nonatomic,assign) SneakyButton *attackButton;

@property (nonatomic,assign) ContactListener *contactListener;

@end
