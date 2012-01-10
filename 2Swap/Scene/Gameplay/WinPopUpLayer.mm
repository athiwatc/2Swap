//  GameControlLayer.m
//  SpaceViking
//
#import "WinPopUpLayer.h"

@implementation WinPopUpLayer

- (void) setGame:(GameplayScrollingLayer *)gamei
{
    game = gamei;
}

- (void) playNextGame
{
    [game playNextGame];
}

- (void) restartGame
{
    [game restartGame];
}

- (void) goHome
{
    [game goHome];
}

-(void)winPopup
{
    
    CCSprite *darkfilter = 
    [CCSprite spriteWithFile:@"dark_filter.png"];
    [darkfilter setPosition:ccp(screenSize.width/2, 
                                screenSize.height/2)];
    [darkfilter opacity];
    [self addChild:darkfilter];
    CCSprite *deathbg = [CCSprite spriteWithFile:@"win_bg.png"];
    [deathbg setPosition:ccp(screenSize.width/2, 
                             screenSize.height/2)];
    [self addChild:deathbg];
    // Main Menu
    CCMenuItemImage *playNextGameButton = [CCMenuItemImage 
                                           itemFromNormalImage:@"play_button.png" 
                                           selectedImage:@"play_button.png" 
                                           disabledImage:@"play_button_disable.png" 
                                           target:self 
                                           selector:@selector(playNextGame)];
    
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
    
    CCSprite *youwinLabel = [CCSprite spriteWithFile:@"you_win_label.png"];
    [youwinLabel setPosition:ccp(screenSize.width/2, screenSize.height/2 + 65)];
    [self addChild:youwinLabel];
    
}

-(id)init {
    self = [super init];
    if (self != nil) {
        // enable touches
        self.isTouchEnabled = YES; 
        screenSize = [CCDirector sharedDirector].winSize;
        [self winPopup];
        CCLOG(@"PopUpLayer initialized");
    }
    return self; 
}

- (void) dealloc
{
    [super dealloc];
}
@end
