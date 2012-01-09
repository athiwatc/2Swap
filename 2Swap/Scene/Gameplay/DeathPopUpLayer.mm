//  GameControlLayer.m
//  SpaceViking
//
#import "DeathPopUpLayer.h"

@implementation DeathPopUpLayer

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

-(void)deathPopup
{
    
    CCSprite *darkfilter = 
    [CCSprite spriteWithFile:@"dark_filter.png"];
    [darkfilter setPosition:ccp(screenSize.width/2, 
                                screenSize.height/2)];
    [darkfilter opacity];
    [self addChild:darkfilter];
    CCSprite *deathbg = [CCSprite spriteWithFile:@"fail_bg.png"];
    [deathbg setPosition:ccp(screenSize.width/2, 
                             screenSize.height/2)];
    [self addChild:deathbg];
    // Main Menu
    CCMenuItemImage *playNextGameButton = [CCMenuItemImage 
                                           itemFromNormalImage:@"play_button.png" 
                                           selectedImage:@"play_button.png" 
                                           disabledImage:nil 
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
    
    CCSprite *youfailLabel = [CCSprite spriteWithFile:@"you_fail_label.png"];
    [youfailLabel setPosition:ccp(screenSize.width/2, screenSize.height/2 + 65)];
    [self addChild:youfailLabel];
    
}


-(id)initWithGame:(GameplayScrollingLayer *)gamei
{
    self = [super init];
    if (self != nil) {
        // enable touches
        self.game = gamei;
        screenSize = [CCDirector sharedDirector].winSize;
        [self deathPopup];
        CCLOG(@"PopUpLayer initialized");
    }
    return self; 
}

-(id)init {
    self = [super init];
    if (self != nil) {
        // enable touches
        self.isTouchEnabled = YES; 
        screenSize = [CCDirector sharedDirector].winSize;
        [self deathPopup];
        CCLOG(@"PopUpLayer initialized");
    }
    return self; 
}

- (void) dealloc
{
    [super dealloc];
}
@end
