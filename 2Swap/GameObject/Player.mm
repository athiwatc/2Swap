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
@synthesize breathingAnim;
@synthesize breathingRedAnim;
@synthesize walkingAnim;
@synthesize walkingRedAnim;
@synthesize deathAnim;
@synthesize deathRedAnim;
@synthesize crouchingAnim;
@synthesize crouchingRedAnim;
@synthesize standingUpAnim;
@synthesize standingUpRedAnim;
@synthesize jumpingAnim;
@synthesize jumpingRedAnim;
@synthesize afterJumpingAnim;
@synthesize afterJumpingRedAnim;
@synthesize winAnim;
@synthesize winRedAnim;
@synthesize explodedAnim;
@synthesize joystick;
@synthesize jumpButton;
@synthesize attackButton;
@synthesize contactListener;

- (void) dealloc {
    joystick = nil;
    jumpButton = nil;
    attackButton = nil;
    [breathingAnim release];
    [breathingRedAnim release];
    [walkingAnim release];
    [walkingRedAnim release];
    [crouchingAnim release];
    [crouchingRedAnim release];
    [standingUpAnim release];
    [standingUpRedAnim release];
    [jumpingAnim release];
    [jumpingRedAnim release];
    [afterJumpingAnim release];
    [afterJumpingRedAnim release];
    [deathAnim release];
    [deathRedAnim release];
    [winAnim release];
    [winRedAnim release];
    [explodedAnim release];
}


-(void)applyJoystick:(SneakyJoystick *)aJoystick forTimeDelta:(float)deltaTime
{
    if (attackButton.active) 
        [self changeState:kStateExploded];
    
    CGPoint scaledVelocity;
    if (onGround) {
        scaledVelocity = ccpMult(aJoystick.velocity, 35.0f);
    }
    else scaledVelocity = ccpMult(aJoystick.velocity, 15.0f);
    [self move:scaledVelocity.x];
    if (scaledVelocity.x < 0.0f) {
        self.flipX = NO;                                        // 3
    } else {
        self.flipX = YES;
    }
}

#pragma mark -
-(void)changeState:(CharacterStates)newState {
    [self stopAllActions];
    id action = nil;
    id movementAction = nil;
    CGPoint newPosition;
    [self setCharacterState:newState];
    
    switch (newState) {
            
            
            
        case kStateExploded:
            
            if (isSwapRed) {
                [self stopAction:action];
                action = [CCAnimate actionWithAnimation:explodedAnim
                                   restoreOriginalFrame:YES];
                isSwapRed = NO;
                gameObjectType = kGameObjectPlayerBlack;
                [self createPlayerFixtureDef:kGIndexFilterPlayerBlackTagValue];
            } else {
                [self stopAction:action];
                action = [CCAnimate actionWithAnimation:explodedAnim
                                   restoreOriginalFrame:YES];
                isSwapRed = YES;
                gameObjectType = kGameObjectPlayerRed;
                [self createPlayerFixtureDef:kGIndexFilterPlayerRedTagValue];
            }
            
        case kStateIdle:
            
            if (isSwapRed) {
                [self setDisplayFrame:[[CCSpriteFrameCache 
                                        sharedSpriteFrameCache] 
                                       spriteFrameByName:@"Idle_red.png"]];
            } else {
                [self setDisplayFrame:[[CCSpriteFrameCache 
                                        sharedSpriteFrameCache] 
                                       spriteFrameByName:@"Idle_black.png"]];
            }
            break;
            
        case kStateWalking:
            //PLAYSOUNDEFFECT(VIKING_WALKING_1);
            
            if (isSwapRed) {
                action = 
                [CCAnimate actionWithAnimation:walkingRedAnim 
                          restoreOriginalFrame:NO];
            } else {
                action = 
                [CCAnimate actionWithAnimation:walkingAnim 
                          restoreOriginalFrame:NO];
            }            
            
            break;
            
            
        case kStateCrouching:
            
            //[self playCrouchingSound];
            if (isSwapRed) {
                action = 
                [CCAnimate actionWithAnimation:crouchingRedAnim 
                          restoreOriginalFrame:NO];
            } else {
                action = 
                [CCAnimate actionWithAnimation:crouchingAnim 
                          restoreOriginalFrame:NO];
            }
            break;
            
        case kStateStandingUp:
            
            if (isSwapRed) {
                action = 
                [CCAnimate actionWithAnimation:standingUpRedAnim 
                          restoreOriginalFrame:NO];
                
            } else {
                action = 
                [CCAnimate actionWithAnimation:standingUpAnim 
                          restoreOriginalFrame:NO];
            }
            break;
            
        case kStateBreathing:
            
            //[self playBreathingSound];
            if (isSwapRed) {
                action = 
                [CCAnimate actionWithAnimation:breathingRedAnim 
                          restoreOriginalFrame:YES];
            } else {
                action = 
                [CCAnimate actionWithAnimation:breathingAnim 
                          restoreOriginalFrame:YES];
            }
            break;
            
        case kStateJumping:
            
            [self jump];//1--
            if (isSwapRed) {
                // Viking Jumping animation with the Mallet
                action = [CCAnimate actionWithAnimation:jumpingRedAnim 
                                   restoreOriginalFrame:NO];
                /*action = [CCSequence actions:
                          [CCSpawn actions:
                           [CCAnimate 
                            actionWithAnimation:jumpingRedAnim 
                            restoreOriginalFrame:YES],
                           nil],
                          [CCAnimate 
                           actionWithAnimation:afterJumpingRedAnim 
                           restoreOriginalFrame:NO],
                          nil];
                 */
            } else {
                // Viking Jumping animation without the Mallet
                action = 
                [CCAnimate actionWithAnimation:jumpingAnim 
                          restoreOriginalFrame:NO];

                /*action = [CCSequence actions:
                            [CCSpawn actions:
                           [CCAnimate 
                            actionWithAnimation:jumpingAnim 
                            restoreOriginalFrame:YES],
                           nil],
                          [CCAnimate 
                           actionWithAnimation:afterJumpingAnim 
                           restoreOriginalFrame:NO],
                          nil];
                 */
            }
            
            break;
        case kStateAfterJumping:
            
            if (isSwapRed) {
                action = 
                [CCAnimate actionWithAnimation:afterJumpingRedAnim 
                          restoreOriginalFrame:YES];
            } else {
                action = 
                [CCAnimate actionWithAnimation:afterJumpingAnim 
                          restoreOriginalFrame:YES];
            }
            
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
            
            //[self playDyingSound];
            if (isSwapRed) {
                action = [CCAnimate 
                          actionWithAnimation:deathRedAnim 
                          restoreOriginalFrame:NO];

            } else {
                action = [CCAnimate 
                          actionWithAnimation:deathAnim 
                          restoreOriginalFrame:NO];
            }
            break;    
            
        default:
            break;
    }
    if (action != nil) {
        [self runAction:action];
    }
}

-(void)updateStateWithDeltaTime:(ccTime)deltaTime {
    if (self.characterState == kStateDead) 
        return; // Nothing to do if the Viking is dead
    
    if ((self.characterState == kStateTakingDamage) && 
        ([self numberOfRunningActions] > 0))
        return; // Currently playing the taking damage animation
    
    //Decrement jump counter
	jumpCounter -= deltaTime;
    
	//Did the gunman just hit the ground?
	if(!onGround){
        if (body->GetLinearVelocity().y <= 0.0) {
            /*if (isSwapRed) {
                [self setDisplayFrame:[[CCSpriteFrameCache 
                                        sharedSpriteFrameCache] 
                                       spriteFrameByName:@"Jump_red_5.png"]];
            } else {
                [self setDisplayFrame:[[CCSpriteFrameCache 
                                        sharedSpriteFrameCache] 
                                       spriteFrameByName:@"Jump_black_5.png"]];
            }*/
        }
		if((body->GetLinearVelocity().y - lastYVelocity) > 2 && lastYVelocity < -2){
            body->SetLinearVelocity(b2Vec2(body->GetLinearVelocity().x,0));
			onGround = YES;
		}else if(body->GetLinearVelocity().y == 0 && lastYVelocity == 0){
			body->SetLinearVelocity(b2Vec2(body->GetLinearVelocity().x,0));
			onGround = YES;
		}
	}
	
	//Did he just fall off the ground without jumping?
	if(onGround){
        /*if (isSwapRed) {
            [self setDisplayFrame:[[CCSpriteFrameCache 
                                    sharedSpriteFrameCache] 
                                   spriteFrameByName:@"Idle_red.png"]];
        } else {
            [self setDisplayFrame:[[CCSpriteFrameCache 
                                    sharedSpriteFrameCache] 
                                   spriteFrameByName:@"Idle_black.png"]];
        }*/
		if(body->GetLinearVelocity().y < -2.0f && lastYVelocity < -2.0f && (body->GetLinearVelocity().y < lastYVelocity)){
			onGround = NO;
		}
	}
    
	//Store last velocity
	lastYVelocity = body->GetLinearVelocity().y;
    
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
    if ((self.characterState == kStateIdle) || 
        (self.characterState == kStateWalking) ||
        (self.characterState == kStateCrouching) ||
        (self.characterState == kStateStandingUp) || 
        (self.characterState == kStateBreathing) || 
        (self.characterState == kStateJumping)) {
        
        if (jumpButton.active && onGround) {
            [self changeState:kStateJumping];
        }
        if (attackButton.active && joystick.velocity.x == 0.0f) {
            [self changeState:kStateExploded];
        } 
        if ((joystick.velocity.x == 0.0f) && 
                   (joystick.velocity.y == 0.0f)) {
            if (self.characterState == kStateCrouching) 
                [self changeState:kStateStandingUp];
        } 
        if (joystick.velocity.y < -0.45f) {
            if (self.characterState != kStateCrouching) 
                [self changeState:kStateCrouching];
        } 
        if (joystick.velocity.x != 0.0f) { // dpad moving
            if (self.characterState != kStateWalking) {
                [self changeState:kStateWalking];
            }
            [self applyJoystick:joystick 
                   forTimeDelta:deltaTime];
        }
    }  
    
    if ([self numberOfRunningActions] == 0) {
        // Not playing an animation
        if (self.characterHealth <= 0.0f) {
            [self changeState:kStateDead];
        } else if (self.characterState == kStateIdle) {
            millisecondsStayingIdle = millisecondsStayingIdle + 
            deltaTime;
            if (millisecondsStayingIdle > kPlayerIdleTimer) {
                [self changeState:kStateBreathing];
            }
        } else if ((self.characterState != kStateCrouching) && 
                   (self.characterState != kStateIdle)){
            millisecondsStayingIdle = 0.0f;
            [self changeState:kStateIdle];
        }
    }
    //CCLOG(@"now state : %i",characterState);
}

-(void) createPlayerFixtureDef : (int) stateTag
{
    if (bodyFixture != NULL) 
    {
        body->DestroyFixture(bodyFixture);
        bodyFixture = NULL;
    }
    b2PolygonShape boxShape;
    b2Vec2 center;
    center.Set(0.0f, -0.15f);
    boxShape.SetAsBox(0.7f, 1.3f, center, 0.0f);
	b2FixtureDef fixtureDef;
    fixtureDef.shape = &boxShape;
	fixtureDef.density = 0.5f;
	fixtureDef.friction = 1.2f;
	fixtureDef.restitution =  0.0f;
    if(stateTag == kGIndexFilterPlayerBlackTagValue) fixtureDef.filter.groupIndex = kGIndexFilterPlayerBlackTagValue;
    else if (stateTag == kGIndexFilterPlayerRedTagValue) fixtureDef.filter.groupIndex = kGIndexFilterPlayerRedTagValue;
    bodyFixture = body->CreateFixture(&fixtureDef);
}

-(void) createBox2dObject:(b2World*)world {
    b2BodyDef playerBodyDef;
	playerBodyDef.type = b2_dynamicBody;
	playerBodyDef.position.Set(self.position.x/PTM_RATIO, self.position.y/PTM_RATIO);
	playerBodyDef.userData = self;
	playerBodyDef.fixedRotation = true;
	
	body = world->CreateBody(&playerBodyDef);
    [self createPlayerFixtureDef:kGIndexFilterPlayerBlackTagValue];
}


-(void) move : (float) x {
    b2Vec2 impulse = b2Vec2(x, 0.0f);
    body->ApplyForce(impulse, body->GetPosition());		
}

-(void) jump {
    CCLOG(@"Jump!!");
    if(onGround && jumpCounter < 0){	
		//Start a jump. Starting requires you to not be moving on the Y.
		jumpCounter = 0.4f;
        body->ApplyLinearImpulse(b2Vec2(0,15.0f), body->GetWorldCenter());    
		onGround = NO;
	}else if(jumpCounter > 0){	
		//Continue a jump
		body->ApplyForce(b2Vec2(0,15.0f), body->GetWorldCenter());
	}   
}

#pragma mark -
-(void)initAnimations {
    
    [self setBreathingAnim:[self loadPlistForAnimationWithName:@"breathingAnim" 
                                                  andClassName:NSStringFromClass([self class])]];
    [self setBreathingRedAnim:[self loadPlistForAnimationWithName:@"breathingRedAnim" andClassName:NSStringFromClass([self class])]];
    
    [self setWalkingAnim:[self loadPlistForAnimationWithName:@"walkingAnim" andClassName:NSStringFromClass([self class])]];
    
    [self setWalkingRedAnim:[self loadPlistForAnimationWithName:@"walkingRedAnim" andClassName:NSStringFromClass([self class])]];
    
    [self setCrouchingAnim:[self loadPlistForAnimationWithName:@"crouchingAnim" andClassName:NSStringFromClass([self class])]];

    [self setCrouchingRedAnim:[self loadPlistForAnimationWithName:@"crouchingRedAnim" andClassName:NSStringFromClass([self class])]];
    
    [self setStandingUpAnim:[self loadPlistForAnimationWithName:@"standingUpAnim" andClassName:NSStringFromClass([self class])]];
    [self setStandingUpRedAnim:[self loadPlistForAnimationWithName:@"standingUpRedAnim" andClassName:NSStringFromClass([self class])]];
        
    [self setJumpingAnim:[self loadPlistForAnimationWithName:@"jumpingAnim" andClassName:NSStringFromClass([self class])]];
    
    [self setJumpingRedAnim:[self loadPlistForAnimationWithName:@"jumpingRedAnim" andClassName:NSStringFromClass([self class])]];

    
    [self setAfterJumpingAnim:[self loadPlistForAnimationWithName:@"afterJumpingAnim" andClassName:NSStringFromClass([self class])]];
    
    
    [self setAfterJumpingRedAnim:[self loadPlistForAnimationWithName:@"afterJumpingRedAnim" andClassName:NSStringFromClass([self class])]];


    [self setDeathAnim:[self loadPlistForAnimationWithName:@"playerDeathAnim" andClassName:NSStringFromClass([self class])]];
    
    [self setDeathRedAnim:[self loadPlistForAnimationWithName:@"playerDeathRedAnim" andClassName:NSStringFromClass([self class])]];
    
    [self setWinAnim:[self loadPlistForAnimationWithName:@"winningAnim" andClassName:NSStringFromClass([self class])]];
    [self setWinRedAnim:[self loadPlistForAnimationWithName:@"winningRedAnim" andClassName:NSStringFromClass([self class])]];
    
    [self setExplodedAnim:[self loadPlistForAnimationWithName:@"explodedAnim" andClassName:NSStringFromClass([self class])]];

}

- (id) init {
	if ((self = [super init])) {
        joystick = nil;
        jumpButton = nil;
        attackButton = nil;
		gameObjectType = kGameObjectPlayerBlack;
        isSwapRed = NO;
        millisecondsStayingIdle = 0.0f;
        jumpCounter = -10.0f;
        onGround = NO;
        [self setCharacterHealth:100.0f];
        [self setFlipX:YES];
        [self initAnimations];
	}
	return self;
}


@end
