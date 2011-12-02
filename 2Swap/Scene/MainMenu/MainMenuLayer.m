//  MainMenuLayer.m
//  SpaceViking
//
#import "MainMenuLayer.h"
@interface MainMenuLayer() 
-(void)displayMainMenu;
@end

@implementation MainMenuLayer

-(void)webLink {
    [[GameManager sharedGameManager]
     openSiteWithLinkType:kLinkTypeBookSite];
}

-(void)showOptions {
    CCLOG(@"Show the Options screen");
    [[GameManager sharedGameManager] runSceneWithID:kOptionsScene];
}

-(void)playGame {
    CCLOG(@"Show the Select Chapter screen");
    [[GameManager sharedGameManager] runSceneWithID:kSelectChapterScene];
}

-(void)playScene:(CCMenuItemFont*)itemPassedIn {
    if ([itemPassedIn tag] == 1) {
        CCLOG(@"Tag 1 found, Scene 1");
        [[GameManager sharedGameManager] runSceneWithID:kIntroScene];
    } else {
        CCLOG(@"Tag was: %d", [itemPassedIn tag]);
        CCLOG(@"Placeholder for next chapters");
    }
}

-(void)displayMainMenu {
    CGSize screenSize = [CCDirector sharedDirector].winSize; 
    if (sceneSelectMenu != nil) {
        [sceneSelectMenu removeFromParentAndCleanup:YES];
    }
    // Main Menu
    CCMenuItemImage *playGameButton = [CCMenuItemImage 
                                       itemFromNormalImage:@"PlayButton-iPhone.png" 
                                       selectedImage:@"PlayButton_press-iPhone.png" 
                                       disabledImage:nil 
                                       target:self 
                                       selector:@selector(playGame)];
    
    CCMenuItemImage *gameCenterButton = [CCMenuItemImage 
                                      itemFromNormalImage:@"GameCenterButton-iPhone.png" 
                                      selectedImage:@"GameCenterButton_press-iPhone.png" 
                                      disabledImage:nil 
                                      target:self 
                                      selector:nil];
    
    CCMenuItemImage *optionsButton = [CCMenuItemImage 
                                      itemFromNormalImage:@"OptionsButton-iPhone.png" 
                                      selectedImage:@"OptionsButton_press-iPhone.png" 
                                      disabledImage:nil 
                                      target:self 
                                      selector:@selector(showOptions)];
    
    mainMenu = [CCMenu 
                menuWithItems:optionsButton,playGameButton,gameCenterButton,nil];
    [mainMenu alignItemsHorizontallyWithPadding: screenSize.height * 0.059f];
    [mainMenu setPosition:
     ccp(screenSize.width / 2.0f,
         screenSize.height * -2.0f)];
    id moveAction = 
    [CCMoveTo actionWithDuration:1.2f 
                        position:ccp(screenSize.width/2.0f,
                                     screenSize.height * .20f)];
    id moveEffect = [CCEaseIn actionWithAction:moveAction rate:1.0f];
    [mainMenu runAction:moveEffect];
    [self addChild:mainMenu z:0 tag:kMainMenuTagValue];
}

-(id)init {
    self = [super init];
    if (self != nil) {
        CGSize screenSize = [CCDirector sharedDirector].winSize; 
        
        //Background
        CCSprite *background = 
        [CCSprite spriteWithFile:@"MainMenuBg-iPhone.png"];
        [background setPosition:ccp(screenSize.width/2, 
                                    screenSize.height/2)];
        [self addChild:background];
        CCSprite *background_layer1 = 
        [CCSprite spriteWithFile:@"MainMenuBg_Layer1-iPhone.png"];
        [background_layer1 setPosition:ccp(screenSize.width/2, 
                                    screenSize.height * 0.35f)];
        [self addChild:background_layer1];

        [self displayMainMenu];
        
        //swapLogo
        CCSprite *swapLogo = [CCSprite spriteWithFile:@"2swap_logo-iPhone.png"];
        [swapLogo setPosition:ccp(screenSize.width/2, 
                                  screenSize.height * 0.65f)];
        
        [swapLogo setScaleX:0.5f];
        [swapLogo setScaleY:0.5f];
        id scaleUp = [CCScaleTo actionWithDuration:0.5f scale:1.0f];
        id rotateAction = [CCEaseElasticInOut actionWithAction:
                           [CCRotateBy actionWithDuration:5.5f
                                                    angle:360]];
        
        id scaleUp1 = [CCScaleTo actionWithDuration:1.0f scale:1.0f];
        id scaleDown1 = [CCScaleTo actionWithDuration:2.0f scale:0.85f];
        
        [self addChild:swapLogo];
        [swapLogo runAction:scaleUp];
        [swapLogo runAction:[CCRepeatForever actionWithAction:
                             [CCSequence 
                              actions:scaleUp1,scaleDown1,nil]]];
        [swapLogo runAction:
         [CCRepeatForever actionWithAction:rotateAction]];
        //Website Button
        CCMenuItemImage *webButton = [CCMenuItemImage 
                                          itemFromNormalImage:@"WebSiteButton-iPhone.png" 
                                          selectedImage:@"WebSiteButton-iPhone.png" 
                                          disabledImage:nil 
                                          target:self 
                                          selector:@selector(webLink)];
        CCMenu *webButtonMenu = [CCMenu menuWithItems:webButton, nil];
        [webButtonMenu setPosition:ccp(screenSize.width * 0.9f, 
                                  screenSize.height * 0.85f)];
        [self addChild:webButtonMenu];

        //creditButton Button
        CCMenuItemImage *creditButton = [CCMenuItemImage 
                                      itemFromNormalImage:@"CreditsButton-iPhone.png" 
                                      selectedImage:@"CreditsButton-iPhone.png" 
                                      disabledImage:nil 
                                      target:self 
                                      selector:nil];
        CCMenu *creditButtonMenu = [CCMenu menuWithItems:creditButton, nil];
        [creditButtonMenu setPosition:ccp(screenSize.width * 0.1f, 
                                       screenSize.height * 0.85f)];
        [self addChild:creditButtonMenu];
                
    }
    return self;
}
@end
