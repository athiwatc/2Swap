//
//  Player.m
//  SimpleBox2dScroller
//
//  Created by min on 3/17/11.
//  Copyright 2011 Min Kwon. All rights reserved.
//

#import "Player.h"
#import "CommonProtocols.h"

@implementation Player
@synthesize body;
@synthesize joystick;
@synthesize jumpButton;
@synthesize attackButton;

- (id) init {
	if ((self = [super init])) {
        joystick = nil;
        jumpButton = nil;
        attackButton = nil;
		gameObjectType = kGameObjectPlayer;
	}
	return self;
}

-(void)applyJoystick:(SneakyJoystick *)aJoystick forTimeDelta:(float)deltaTime
{
    CGPoint scaledVelocity = ccpMult(aJoystick.velocity, 0.4f);
    b2Vec2 impulse = b2Vec2(scaledVelocity.x, 0.0f);
    body->ApplyLinearImpulse(impulse, body->GetWorldCenter());
}

#pragma mark -
-(void)changeState:(CharacterStates)newState {
    [self stopAllActions];
    id action = nil;
    id movementAction = nil;
    CGPoint newPosition;
    [self setCharacterState:newState];
    
    switch (newState) {
        case kStateIdle:
            /*
            if (isCarryingMallet) {
                [self setDisplayFrame:[[CCSpriteFrameCache 
                                        sharedSpriteFrameCache] 
                                       spriteFrameByName:@"sv_mallet_1.png"]];
            } else {
                [self setDisplayFrame:[[CCSpriteFrameCache 
                                        sharedSpriteFrameCache] 
                                       spriteFrameByName:@"sv_anim_1.png"]];
            }*/
            break;
            
        case kStateWalking:
            //PLAYSOUNDEFFECT(VIKING_WALKING_1);
            /*
            if (isCarryingMallet) {
                action = 
                [CCAnimate actionWithAnimation:walkingMalletAnim 
                          restoreOriginalFrame:NO];
            } else {
                action = 
                [CCAnimate actionWithAnimation:walkingAnim 
                          restoreOriginalFrame:NO];
            }            
            */
            break;
            
            
        case kStateCrouching:
            /*
            [self playCrouchingSound];
            if (isCarryingMallet) {
                action = 
                [CCAnimate actionWithAnimation:crouchingMalletAnim 
                          restoreOriginalFrame:NO];
            } else {
                action = 
                [CCAnimate actionWithAnimation:crouchingAnim 
                          restoreOriginalFrame:NO];
            }*/
            break;
            
        case kStateStandingUp:
            /*
            if (isCarryingMallet) {
                action = 
                [CCAnimate actionWithAnimation:standingUpMalletAnim 
                          restoreOriginalFrame:NO];
                
            } else {
                action = 
                [CCAnimate actionWithAnimation:standingUpAnim 
                          restoreOriginalFrame:NO];
            }*/
            break;
            
        case kStateBreathing:
            /*
            [self playBreathingSound];
            if (isCarryingMallet) {
                action = 
                [CCAnimate actionWithAnimation:breathingMalletAnim 
                          restoreOriginalFrame:YES];
            } else {
                action = 
                [CCAnimate actionWithAnimation:breathingAnim 
                          restoreOriginalFrame:YES];
            }*/
            break;
            
        case kStateJumping:
            /*
            newPosition = ccp(screenSize.width * 0.2f, 0.0f);
            if ([self flipX] == YES) {
                newPosition = ccp(newPosition.x * -1.0f, 0.0f);
            } 
            movementAction = [CCJumpBy actionWithDuration:0.5f 
                                                 position:newPosition 
                                                   height:160.0f 
                                                    jumps:1];
            
            if (isCarryingMallet) {
                // Viking Jumping animation with the Mallet
                action = [CCSequence actions:
                          [CCAnimate 
                           actionWithAnimation:crouchingMalletAnim 
                           restoreOriginalFrame:NO],
                          [CCSpawn actions:
                           [CCAnimate 
                            actionWithAnimation:jumpingMalletAnim 
                            restoreOriginalFrame:YES],
                           movementAction,
                           nil],
                          [CCAnimate 
                           actionWithAnimation:afterJumpingMalletAnim 
                           restoreOriginalFrame:NO],
                          nil];
            } else {
                // Viking Jumping animation without the Mallet
                action = [CCSequence actions:
                          [CCAnimate 
                           actionWithAnimation:crouchingAnim 
                           restoreOriginalFrame:NO],
                          [CCSpawn actions:
                           [CCAnimate 
                            actionWithAnimation:jumpingAnim 
                            restoreOriginalFrame:YES],
                           movementAction,
                           nil],
                          [CCAnimate 
                           actionWithAnimation:afterJumpingAnim 
                           restoreOriginalFrame:NO],
                          nil];
            }*/
            
            [self jump];		    
            break;
            
        case kStateAttacking:
            /*
            if (isCarryingMallet == YES) {
                [self playSwingingSound];
                action = [CCAnimate 
                          actionWithAnimation:malletPunchAnim 
                          restoreOriginalFrame:YES];
            } else {
                PLAYSOUNDEFFECT(VIKING_PUNCHING);
                if (kLeftHook == myLastPunch) {
                    // Execute a right hook
                    myLastPunch = kRightHook;
                    action = [CCAnimate 
                              actionWithAnimation:rightPunchAnim 
                              restoreOriginalFrame:NO];
                } else {
                    // Execute a left hook
                    myLastPunch = kLeftHook;
                    action = [CCAnimate 
                              actionWithAnimation:leftPunchAnim 
                              restoreOriginalFrame:NO];
                }
            }
            */
            break;
            
        case kStateTakingDamage:
            /*
            [self playTakingDamageSound];
            self.characterHealth = self.characterHealth - 10.0f;
            action = [CCAnimate 
                      actionWithAnimation:phaserShockAnim 
                      restoreOriginalFrame:YES]; 
            */
            break;
            
        case kStateDead:
            /*
            [self playDyingSound];
            action = [CCAnimate 
                      actionWithAnimation:deathAnim 
                      restoreOriginalFrame:NO];
             */
            break;    
            
        default:
            break;
    }
    if (action != nil) {
        [self runAction:action];
    }
}

-(void)updateStateWithDeltaTime:(ccTime)deltaTime {
    /*if (self.characterState == kStateDead) 
        return; // Nothing to do if the Viking is dead
    
    if ((self.characterState == kStateTakingDamage) && 
        ([self numberOfRunningActions] > 0))
        return; // Currently playing the taking damage animation
    */
    // Check for collisions
    // Change this to keep the object count from querying it each time
    /*
    CGRect myBoundingBox = [self adjustedBoundingBox];
    for (GameCharacter *character in listOfGameObjects) {
        // This is Ole the Viking himself
        // No need to check collision with one's self
        if ([character tag] == kVikingSpriteTagValue) 
            continue;
        
        CGRect characterBox = [character adjustedBoundingBox];
        if (CGRectIntersectsRect(myBoundingBox, characterBox)) {
            // Remove the PhaserBullet from the scene
            if ([character gameObjectType] == kEnemyTypePhaser) {
                [self changeState:kStateTakingDamage];
                [character changeState:kStateDead];
            } else if ([character gameObjectType] == 
                       kPowerUpTypeMallet) {
                // Update the frame to indicate Viking is
                // carrying the mallet
                //isCarryingMallet = YES;
                [self changeState:kStateIdle];
                // Remove the Mallet from the scene
                [character changeState:kStateDead];
            } else if ([character gameObjectType] == 
                       kPowerUpTypeHealth) {
                [self setCharacterHealth:100.0f];
                // Remove the health power-up from the scene
                [character changeState:kStateDead];
            }
        }
    }    
    */
    //[self checkAndClampSpritePosition];
    /*if ((self.characterState == kStateIdle) || 
        (self.characterState == kStateWalking) ||
        (self.characterState == kStateCrouching) ||
        (self.characterState == kStateStandingUp) || 
        (self.characterState == kStateBreathing)) {
        */
        if (jumpButton.active) {
            [self changeState:kStateJumping];
        } /*else if (attackButton.active) {
            [self changeState:kStateAttacking];
        } else if ((joystick.velocity.x == 0.0f) && 
                   (joystick.velocity.y == 0.0f)) {
            if (self.characterState == kStateCrouching) 
                [self changeState:kStateStandingUp];
        } else if (joystick.velocity.y < -0.45f) {
            if (self.characterState != kStateCrouching) 
                [self changeState:kStateCrouching];
        } else if (joystick.velocity.x != 0.0f) { // dpad moving
            if (self.characterState != kStateWalking)
                [self changeState:kStateWalking];
            [self applyJoystick:joystick 
                   forTimeDelta:deltaTime];
        } */
    //}  
    /*
    if ([self numberOfRunningActions] == 0) {
        // Not playing an animation
        if (self.characterHealth <= 0.0f) {
            [self changeState:kStateDead];
        } else if (self.characterState == kStateIdle) {
            millisecondsStayingIdle = millisecondsStayingIdle + 
            deltaTime;
            if (millisecondsStayingIdle > kVikingIdleTimer) {
                [self changeState:kStateBreathing];
            }
        } else if ((self.characterState != kStateCrouching) && 
                   (self.characterState != kStateIdle)){
            millisecondsStayingIdle = 0.0f;
            [self changeState:kStateIdle];
        }
    }*/
    [self applyJoystick:joystick 
           forTimeDelta:deltaTime];

}


-(void) createBox2dObject:(b2World*)world {
    b2BodyDef playerBodyDef;
	playerBodyDef.type = b2_dynamicBody;
	playerBodyDef.position.Set(self.position.x/PTM_RATIO, self.position.y/PTM_RATIO);
	playerBodyDef.userData = self;
	playerBodyDef.fixedRotation = true;
	
	body = world->CreateBody(&playerBodyDef);
	
	b2CircleShape circleShape;
	circleShape.m_radius = 0.7;
	b2FixtureDef fixtureDef;
	fixtureDef.shape = &circleShape;
	fixtureDef.density = 1.0f;
	fixtureDef.friction = 1.0f;
	fixtureDef.restitution =  0.0f;
	body->CreateFixture(&fixtureDef);
}

-(void) moveLeft {
    b2Vec2 impulse = b2Vec2(-5.0f, 0.0f);
    body->ApplyLinearImpulse(impulse, body->GetWorldCenter());		
}

-(void) moveRight {
    b2Vec2 impulse = b2Vec2(5.0f, 0.0f);
    body->ApplyLinearImpulse(impulse, body->GetWorldCenter());		
}

-(void) jump {
    CCLOG(@"Jump!!");
    b2Vec2 impulse = b2Vec2(2.0f, 10.0f);
    body->ApplyLinearImpulse(impulse, body->GetWorldCenter());		    
}
@end
