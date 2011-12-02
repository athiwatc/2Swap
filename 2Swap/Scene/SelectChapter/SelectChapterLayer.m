//
//  SelectChapterLayer.m
//  2Swap
//
//  Created by Wairung Tiranalinvit on 11/15/54 BE.
//  Copyright 2554 __MyCompanyName__. All rights reserved.
//

#import "SelectChapterLayer.h"
#import "CCScrollLayer.h"
#import "Chapter.h"
#import "Chapters.h"
#import "ChapterParser.h"
#import "GameData.h"
#import "GameDataParser.h"


@implementation SelectChapterLayer

-(void)returnToMainMenu {
	[[GameManager sharedGameManager] runSceneWithID:kMainMenuScene];
}

- (void)onSelectChapter:(CCMenuItemImage *)sender { 
    
    //CCLOG(@"writing the selected stage to GameData.xml as %i", sender.tag);
    GameData *gameData = [GameDataParser loadData];
    [gameData setSelectedChapter:sender.tag];
    [GameDataParser saveData:gameData];    
    //[SceneManager goLevelSelect];
}

- (CCLayer*)layerWithChapterName:(NSString*)chapterName 
                   chapterNumber:(int)chapterNumber 
                      screenSize:(CGSize)screenSize {
    
    CCLayer *layer = [[CCLayer alloc] init];
    
    CCMenuItemImage *image = [CCMenuItemImage itemFromNormalImage:@"StickyNote-iPhone.png" 
                                                        selectedImage:@"StickyNote-iPhone.png" 
                                                               target:self 
                                                             selector:@selector(onSelectChapter:)];
    image.tag = chapterNumber;
    CCMenu *menu = [CCMenu menuWithItems: image, nil];
    [menu alignItemsVertically];
    [layer addChild: menu];    
    
    
    // Put a label in the new layer based on the passed chapterName
    int largeFont = [CCDirector sharedDirector].winSize.height / kFontScaleLarge;
    CCLabelTTF *layerLabel = [CCLabelTTF labelWithString:chapterName fontName:@"Marker Felt" fontSize:largeFont];
    layerLabel.position =  ccp( screenSize.width / 2 , screenSize.height / 2 + 10 );
    layerLabel.rotation = -6.0f;
    layerLabel.color = ccc3(95,58,0);
    [layer addChild:layerLabel];
    
    return layer;
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

        NSMutableArray *layers = [NSMutableArray new];
        
        Chapters *chapters = [ChapterParser loadData];
        
        for (Chapter *chapter in chapters.chapters) {
            // Create a layer for each of the stages found in Chapters.xml
            CCLayer *layer = [self layerWithChapterName:chapter.name chapterNumber:chapter.number screenSize:screenSize];
            [layers addObject:layer];
        }
        
        
        
        // Set up the swipe-able layers
        CCScrollLayer *scroller = [[CCScrollLayer alloc] initWithLayers:layers 
                                                            widthOffset:230];
        
        
        GameData *gameData = [GameDataParser loadData];
        [scroller selectPage:(gameData.selectedChapter -1)];
        
        [self addChild:scroller];
        
        [scroller release];
        [layers release];

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
