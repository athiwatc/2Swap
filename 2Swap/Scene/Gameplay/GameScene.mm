//  GameScene2.m
//  SpaceViking
//
#import "GameScene.h"

@implementation GameScene


- (void) applyPausePopUp
{
    pausepop = [PausePopUpLayer node];
    [pausepop setGame:scrollingLayer];
    [self addChild:pausepop z:4];
}

- (void) removePausePopUp
{
    [self removeChild:pausepop cleanup:YES];
}

- (void) applyWinPopUp
{
    winpop = [WinPopUpLayer node];
    [winpop setGame:scrollingLayer];
    [self addChild:winpop z:4];
}

- (void) removeWinPopUp
{
    [self removeChild:winpop cleanup:YES];
}

- (void) applyDeathPopUp
{
    deathpop = [DeathPopUpLayer node];
    [deathpop setGame:scrollingLayer];
    [self addChild:deathpop z:4];
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
        
        LevelManager *level_manager = [[LevelManager alloc] init];
        
        // Initialize the Control Layer
        controlLayer = [GameControlLayer node];
        [self addChild:controlLayer z:2 tag:2];
        
        // Gameplay Layer
        scrollingLayer = [GameplayScrollingLayer node];
        [scrollingLayer setupLevel:level_manager];
        [scrollingLayer connectControlsWithJoystick:[controlLayer leftJoystick] 
                                      andJumpButton:[controlLayer jumpButton]
                                    andAttackButton:[controlLayer attackButton]];
        [scrollingLayer createNewWorld];
        [self addChild:scrollingLayer z:1 tag:1];
        
        [scrollingLayer setCurrentScene:self];
        
        HUDLayer *hud = [HUDLayer node];
        [hud setGame:scrollingLayer];
        [self addChild:hud z:3];
    }
    return self;
}
@end
