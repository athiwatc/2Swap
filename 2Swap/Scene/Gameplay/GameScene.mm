//  GameScene2.m
//  SpaceViking
//
#import "GameScene.h"

@implementation GameScene


- (void) applyWinPopUp
{
    winpop = [WinPopUpLayer node];
    [winpop setGame:scrollingLayer];
    [self addChild:winpop z:2];

}

- (void) removeWinPopUp
{
    [self removeChild:winpop cleanup:YES];
}

- (void) applyDeathPopUp
{
    deathpop = [DeathPopUpLayer node];
    [deathpop setGame:scrollingLayer];
    [self addChild:deathpop z:2];
}

- (void) removeDeathPopUp
{
    [self removeChild:deathpop cleanup:YES];
}

-(id)init {
    self = [super init];
    if (self != nil) {
        //PopUpLayer *popup = [PopUpLayer node];
        //[self addChild:popup];
        // Background Layer
        StaticBackgroundLayer *backgroundLayer = 
        [StaticBackgroundLayer node];
        [self addChild:backgroundLayer z:0];
        
        // Initialize the Control Layer
        controlLayer = [GameControlLayer node];
        [self addChild:controlLayer z:2 tag:2];
        
        // Gameplay Layer
        scrollingLayer = [GameplayScrollingLayer node];
        [scrollingLayer connectControlsWithJoystick:[controlLayer leftJoystick] 
                                      andJumpButton:[controlLayer jumpButton]
                                    andAttackButton:[controlLayer attackButton]];
        [self addChild:scrollingLayer z:1 tag:1];
        
        [scrollingLayer setCurrentScene:self];
        
    }
    return self;
}
@end
