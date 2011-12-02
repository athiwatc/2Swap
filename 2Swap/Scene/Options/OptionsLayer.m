//
//  OptionsLayer.m
//  SpaceViking
//

#import "OptionsLayer.h"


@implementation OptionsLayer
-(void)returnToMainMenu {
	[[GameManager sharedGameManager] runSceneWithID:kMainMenuScene];
}
-(void)showCredits {
	[[GameManager sharedGameManager] runSceneWithID:kCreditsScene];
}

-(void)musicTogglePressed {
	if ([[GameManager sharedGameManager] isMusicON]) {
		CCLOG(@"OptionsLayer-> Turning Game Music OFF");
		[[GameManager sharedGameManager] setIsMusicON:NO];
	} else {
		CCLOG(@"OptionsLayer-> Turning Game Music ON");
		[[GameManager sharedGameManager] setIsMusicON:YES];
	}
}

-(void)SFXTogglePressed {
	if ([[GameManager sharedGameManager] isSoundEffectsON]) {
		CCLOG(@"OptionsLayer-> Turning Sound Effects OFF");
		[[GameManager sharedGameManager] setIsSoundEffectsON:NO];
	} else {
		CCLOG(@"OptionsLayer-> Turning Sound Effects ON");
		[[GameManager sharedGameManager] setIsSoundEffectsON:YES];
	}
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
        
        CCSprite *optionMenuLayout = 
        [CCSprite spriteWithFile:@"OptionMenuLayout-iPhone.png"];
        [optionMenuLayout setPosition:ccp(screenSize.width/2, 
                                          screenSize.height * 0.55f)];
        [self addChild:optionMenuLayout];

        
		CCMenuItemImage *musicOnLabel = [CCMenuItemImage 
                                           itemFromNormalImage:@"OnButton-iPhone.png" 
                                           selectedImage:@"OnButton-iPhone.png" 
                                           disabledImage:nil 
                                           target:self 
                                         selector:nil];
		CCMenuItemImage *musicOffLabel = [CCMenuItemImage 
                                         itemFromNormalImage:@"OffButton-iPhone.png" 
                                         selectedImage:@"OffButton-iPhone.png" 
                                         disabledImage:nil 
                                         target:self 
                                         selector:nil];
        CCMenuItemImage *SFXOnLabel = [CCMenuItemImage 
                                         itemFromNormalImage:@"OnButton-iPhone.png" 
                                         selectedImage:@"OnButton-iPhone.png" 
                                         disabledImage:nil 
                                         target:self 
                                         selector:nil];
		CCMenuItemImage *SFXOffLabel = [CCMenuItemImage 
                                          itemFromNormalImage:@"OffButton-iPhone.png" 
                                          selectedImage:@"OffButton-iPhone.png" 
                                          disabledImage:nil 
                                          target:self 
                                          selector:nil];

		CCMenuItemToggle *musicToggle = [CCMenuItemToggle itemWithTarget:self 
																selector:@selector(musicTogglePressed) 
																   items:musicOnLabel,musicOffLabel,nil];
		
		CCMenuItemToggle *SFXToggle = [CCMenuItemToggle itemWithTarget:self 
																selector:@selector(SFXTogglePressed) 
																   items:SFXOnLabel,SFXOffLabel,nil];
		
        CCMenuItemImage *backButton = [CCMenuItemImage 
                                        itemFromNormalImage:@"BackButton-iPhone.png" 
                                        selectedImage:@"BackButton-iPhone.png" 
                                        disabledImage:nil 
                                        target:self 
                                        selector:@selector(returnToMainMenu)];

		CCMenu *optionsMenu = [CCMenu menuWithItems:musicToggle,
							   SFXToggle,nil];
        CCMenu *backMenu = [CCMenu menuWithItems:backButton, nil];
		[optionsMenu alignItemsVerticallyWithPadding:20.0f];
		[optionsMenu setPosition:ccp(screenSize.width * 0.67f, screenSize.height*0.45f)];
		[self addChild:optionsMenu];
        
        CCSprite *soundFXLabel = [CCSprite spriteWithFile:@"SoundFXLabel-iPhone.png"];
        [soundFXLabel setPosition:ccp(screenSize.width * 0.32f, screenSize.height*0.37f)];
        [self addChild:soundFXLabel];
        
        CCSprite *musicLabel = [CCSprite spriteWithFile:@"MusicLabel-iPhone.png"];
        [musicLabel setPosition:ccp(screenSize.width * 0.32f, screenSize.height*0.55f)];
        [self addChild:musicLabel];
        
        [backMenu setPosition:ccp(screenSize.width * 0.9f, screenSize.height * 0.1f)];
        [self addChild:backMenu];
        
        if ([[GameManager sharedGameManager] isMusicON] == NO) {
            [musicToggle setSelectedIndex:1]; // Music is OFF
        }
        
        if ([[GameManager sharedGameManager] isSoundEffectsON] == NO) {
            [SFXToggle setSelectedIndex:1]; // SFX are OFF
        }
	}
	return self;
}
@end
