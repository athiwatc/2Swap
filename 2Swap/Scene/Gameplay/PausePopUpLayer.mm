//  GameControlLayer.m
//  SpaceViking
//
#import "PausePopUpLayer.h"

@implementation PausePopUpLayer

- (void) setGame:(GameplayScrollingLayer *)gamei
{
    game = gamei;
}

- (void) unpauseGame
{
    [game unpauseGame];
}

- (void) restartGame
{
    [game restartGame];
}

- (void) goHome
{
    [game goHome];
}

-(void)pausePopup
{
    
    CCSprite *darkfilter = 
    [CCSprite spriteWithFile:@"dark_filter.png"];
    [darkfilter setPosition:ccp(screenSize.width/2, 
                                screenSize.height/2)];
    [darkfilter opacity];
    [self addChild:darkfilter];
    CCSprite *pausebg = [CCSprite spriteWithFile:@"pause_bg.png"];
    [pausebg setPosition:ccp(screenSize.width/2, 
                             screenSize.height/2)];
    [self addChild:pausebg];
    // Main Menu
    CCMenuItemImage *playNextGameButton = [CCMenuItemImage 
                                           itemFromNormalImage:@"play_button.png" 
                                           selectedImage:@"play_button.png" 
                                           disabledImage:@"play_button_disable.png" 
                                           target:self 
                                           selector:@selector(unpauseGame)];
    
    CCMenuItemImage *replayButton = [CCMenuItemImage 
                                     itemFromNormalImage:@"replay_button.png" 
                                     selectedImage:@"replay_button.png" 
                                     disabledImage:nil 
                                     target:self 
                                     selector:@selector(restartGame)];
    
    CCMenuItemImage *homeButton = [CCMenuItemImage 
                                   itemFromNormalImage:@"home_button.png" 
                                   selectedImage:@"home_button.png" 
                                   disabledImage:nil 
                                   target:self 
                                   selector:@selector(goHome)];
    
    CCMenu* playNextMenu = [CCMenu 
                            menuWithItems:playNextGameButton,nil];
    CCMenu* replayMenu = [CCMenu 
                          menuWithItems:replayButton,nil];
    CCMenu* homeMenu = [CCMenu 
                        menuWithItems:homeButton,nil];
    [playNextMenu setPosition:ccp(screenSize.width/2, screenSize.height/2 - 65)];
    [replayMenu setPosition:ccp(screenSize.width/2 - 70, screenSize.height/2 - 50)];
    [homeMenu setPosition:ccp(screenSize.width/2 + 70, screenSize.height/2 - 50)];
    [self addChild:playNextMenu];
    [self addChild:replayMenu];
    [self addChild:homeMenu];
    
    CCSprite *pauseLabel = [CCSprite spriteWithFile:@"pause_label.png"];
    [pauseLabel setPosition:ccp(screenSize.width/2, screenSize.height/2 + 65)];
    [self addChild:pauseLabel];
    
}

-(id)init {
    self = [super init];
    if (self != nil) {
        // enable touches
        self.isTouchEnabled = YES; 
        screenSize = [CCDirector sharedDirector].winSize;
        [self pausePopup];
        CCLOG(@"PopUpLayer initialized");
    }
    return self; 
}

- (void) dealloc
{
    [super dealloc];
}
@end
