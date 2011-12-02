//
//  SelectChapterLayer.m
//  2Swap
//
//  Created by Wairung Tiranalinvit on 11/15/54 BE.
//  Copyright 2554 __MyCompanyName__. All rights reserved.
//

#import "SelectChapterLayer.h"

@implementation SelectChapterLayer

-(void)returnToMainMenu {
	[[GameManager sharedGameManager] runSceneWithID:kMainMenuScene];
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

        //BackMenu
        CCMenuItemImage *backButton = [CCMenuItemImage 
                                       itemFromNormalImage:@"BackButton1-iPhone.png" 
                                       selectedImage:@"BackButton1-iPhone.png" 
                                       disabledImage:nil 
                                       target:self 
                                       selector:@selector(returnToMainMenu)];
        CCMenu *backMenu = [CCMenu menuWithItems:backButton, nil];
        
        [backMenu setPosition:ccp(screenSize.width / 2, screenSize.height * 0.1f)];
        [self addChild:backMenu];
        
        //Select Level
        CCSprite *select_label = [CCSprite spriteWithFile:@"Select_Level_Label-iPhone.png"];
        [select_label setPosition:ccp(screenSize.width/2, screenSize.height * 0.9f)];
        [self addChild:select_label];
        
        //Star
        CCSprite *star = [CCSprite spriteWithFile:@"Star_small-iPhone.png"];
        [star setPosition:ccp(screenSize.width * 0.08f, screenSize.height * 0.12f)];
        [self addChild:star];
        
        
    }
    return self;
}

@end
