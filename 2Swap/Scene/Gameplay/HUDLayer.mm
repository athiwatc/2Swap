//  GameControlLayer.m
//  SpaceViking
//
#import "HUDLayer.h"

@implementation HUDLayer

- (void) setGame:(GameplayScrollingLayer *)gamei
{
    game = gamei;
}

- (void) pauseGame
{
    CCLOG(@"Pause!!!!!");
    [game pauseGame];
}

-(void) pauseButtonInit
{
    
    // Main Menu
    CCMenuItemImage *pauseButton = [CCMenuItemImage 
                                           itemFromNormalImage:@"pause_button.png" 
                                           selectedImage:@"pause_button.png" 
                                           disabledImage:nil 
                                           target:self 
                                           selector:@selector(pauseGame)];
    
    CCMenu* pauseMenu = [CCMenu 
                            menuWithItems:pauseButton,nil];
    [pauseMenu setPosition:ccp(25, 300)];
    [self addChild:pauseMenu];
    
}

-(id)init {
    self = [super init];
    if (self != nil) {
        // enable touches
        self.isTouchEnabled = YES; 
        screenSize = [CCDirector sharedDirector].winSize;
        [self pauseButtonInit];
        CCLOG(@"HUD initialized");
    }
    return self; 
}

- (void) dealloc
{
    [super dealloc];
}
@end
