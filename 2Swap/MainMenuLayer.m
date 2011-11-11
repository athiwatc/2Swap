//  MainMenuLayer.m
//  SpaceViking
//
#import "MainMenuLayer.h"
@interface MainMenuLayer() 
-(void)displayMainMenu;
-(void)displaySceneSelection;
@end

@implementation MainMenuLayer
-(void)buyBook {
    [[GameManager sharedGameManager]
     openSiteWithLinkType:kLinkTypeBookSite];
}

-(void)showOptions {
    CCLOG(@"Show the Options screen");
    [[GameManager sharedGameManager] runSceneWithID:kOptionsScene];
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
                                       itemFromNormalImage:@"PlayButton.png" 
                                       selectedImage:@"PlayButton_press.png" 
                                       disabledImage:nil 
                                       target:self 
                                       selector:@selector(displaySceneSelection)];
    
    CCMenuItemImage *gameCenterButton = [CCMenuItemImage 
                                      itemFromNormalImage:@"GameCenterButton.png" 
                                      selectedImage:@"GameCenterButton_press.png" 
                                      disabledImage:nil 
                                      target:self 
                                      selector:@selector(buyBook)];
    
    CCMenuItemImage *optionsButton = [CCMenuItemImage 
                                      itemFromNormalImage:@"OptionsButton.png" 
                                      selectedImage:@"OptionsButton_press.png" 
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

-(void)displaySceneSelection {
    CGSize screenSize = [CCDirector sharedDirector].winSize; 
    if (mainMenu != nil) {
        [mainMenu removeFromParentAndCleanup:YES];
    }
    
    CCLabelBMFont *playScene1Label = 
    [CCLabelBMFont labelWithString:@"Oli Awakes!" 
                           fntFile:@"VikingSpeechFont64.fnt"];
    CCMenuItemLabel *playScene1 = 
    [CCMenuItemLabel itemWithLabel:playScene1Label target:self 
                          selector:@selector(playScene:)];
    [playScene1 setTag:1];
    
    CCLabelBMFont *playScene2Label = 
    [CCLabelBMFont labelWithString:@"Dogs of Loki!" 
                           fntFile:@"VikingSpeechFont64.fnt"];
    CCMenuItemLabel *playScene2 = 
    [CCMenuItemLabel itemWithLabel:playScene2Label target:self 
                          selector:@selector(playScene:)];
    [playScene2 setTag:2];
    
    CCLabelBMFont *playScene3Label = 
    [CCLabelBMFont labelWithString:@"Mad Dreams of the Dead!" 
                           fntFile:@"VikingSpeechFont64.fnt"];
    CCMenuItemLabel *playScene3 = [CCMenuItemLabel itemWithLabel:playScene3Label target:self 
                                                        selector:@selector(playScene:)];
    [playScene3 setTag:3];
    
    CCLabelBMFont *playScene4Label = 
    [CCLabelBMFont labelWithString:@"Descent Into Hades!" 
                                     fntFile:@"VikingSpeechFont64.fnt"];
	CCMenuItemLabel *playScene4 = [CCMenuItemLabel itemWithLabel:playScene4Label target:self 
														selector:@selector(playScene:)];
	[playScene4 setTag:4];
    
    CCLabelBMFont *playScene5Label = 
    [CCLabelBMFont labelWithString:@"Escape!" 
                                     fntFile:@"VikingSpeechFont64.fnt"];
	CCMenuItemLabel *playScene5 = [CCMenuItemLabel itemWithLabel:playScene5Label target:self 
														selector:@selector(playScene:)];
	[playScene5 setTag:5];
    
    CCLabelBMFont *backButtonLabel = 
    [CCLabelBMFont labelWithString:@"Back" 
                           fntFile:@"VikingSpeechFont64.fnt"];
    CCMenuItemLabel *backButton = 
    [CCMenuItemLabel itemWithLabel:backButtonLabel target:self 
                          selector:@selector(displayMainMenu)];
    
    sceneSelectMenu = [CCMenu menuWithItems:playScene1,
                       playScene2,playScene3,playScene4,playScene5,backButton,nil];
    [sceneSelectMenu alignItemsVerticallyWithPadding:screenSize.height * 0.059f];
    [sceneSelectMenu setPosition:ccp(screenSize.width * 2, 
                                     screenSize.height / 2)];
    
    id moveAction = [CCMoveTo actionWithDuration:0.5f 
                                        position:ccp(screenSize.width * 0.75f, 
                                                     screenSize.height/2)];
    id moveEffect = [CCEaseIn actionWithAction:moveAction rate:1.0f];
    [sceneSelectMenu runAction:moveEffect];
    [self addChild:sceneSelectMenu z:1 tag:kSceneMenuTagValue];
}
-(id)init {
    self = [super init];
    if (self != nil) {
        CGSize screenSize = [CCDirector sharedDirector].winSize; 
        
        //Background
        CCSprite *background = 
        [CCSprite spriteWithFile:@"MainMenuBg.png"];
        [background setPosition:ccp(screenSize.width/2, 
                                    screenSize.height/2)];
        [self addChild:background];
        CCSprite *background_layer1 = 
        [CCSprite spriteWithFile:@"MainMenuBg_Layer1.png"];
        [background_layer1 setPosition:ccp(screenSize.width/2, 
                                    screenSize.height * 0.35f)];
        [self addChild:background_layer1];

        [self displayMainMenu];
        
        //swapLogo
        CCSprite *swapLogo = [CCSprite spriteWithFile:@"2swap_logo_low.png"];
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
                                          itemFromNormalImage:@"WebSiteButton.png" 
                                          selectedImage:@"WebSiteButton.png" 
                                          disabledImage:nil 
                                          target:self 
                                          selector:@selector(showOptions)];
        [webButton setPosition:ccp(screenSize.width * 0.9f, 
                                  screenSize.height * 0.85f)];
        [self addChild:webButton];

        //creditButton Button
        CCMenuItemImage *creditButton = [CCMenuItemImage 
                                      itemFromNormalImage:@"CreditsButton.png" 
                                      selectedImage:@"CreditsButton.png" 
                                      disabledImage:nil 
                                      target:self 
                                      selector:@selector(showOptions)];
        [creditButton setPosition:ccp(screenSize.width * 0.1f, 
                                   screenSize.height * 0.85f)];
        [self addChild:creditButton];
                
    }
    return self;
}
@end
