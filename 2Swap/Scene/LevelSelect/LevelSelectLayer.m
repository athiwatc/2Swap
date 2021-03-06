//
//  SelectChapterLayer.m
//  2Swap
//
//  Created by Wairung Tiranalinvit on 11/15/54 BE.
//  Copyright 2554 __MyCompanyName__. All rights reserved.
//

#import "LevelSelectLayer.h"
#import "Level.h"
#import "Levels.h"
#import "LevelParser.h"
#import "GameData.h"
#import "GameDataParser.h"
#import "Chapter.h"
#import "Chapters.h"
#import "ChapterParser.h"

@implementation LevelSelectLayer

@synthesize iPad, device;

- (void) onPlay: (CCMenuItemImage*) sender {
    
    // the selected level is determined by the tag in the menu item 
    int selectedLevel = sender.tag;
    
    // store the selected level in GameData
    GameData *gameData = [GameDataParser loadData];
    gameData.selectedLevel = selectedLevel;
    [GameDataParser saveData:gameData];
    
    // load the game scene
    [[GameManager sharedGameManager] runSceneWithID:kGameLevel1];
}

- (void)onBack: (id) sender {
    /* 
     This is where you choose where clicking 'back' sends you.
     */
	[[GameManager sharedGameManager] runSceneWithID:kChapterSelectionScene];
}

- (void)addBackButton {
    
    if (self.iPad) {
        
        // Create a menu image button for iPad
        CCMenuItemImage *goBack = [CCMenuItemImage itemFromNormalImage:@"Arrow-Normal-iPad.png" 
                                                         selectedImage:@"Arrow-Selected-iPad.png"
                                                                target:self 
                                                              selector:@selector(onBack:)];
        // Add menu image to menu
        CCMenu *back = [CCMenu menuWithItems: goBack, nil];
        
        // position menu in the bottom left of the screen (0,0 starts bottom left)
        back.position = ccp(64, 64);
        
        // Add menu to this scene
        [self addChild: back];
    }
    else {
        // Create a menu image button for iPhone / iPod Touch
        CCMenuItemImage *goBack = [CCMenuItemImage itemFromNormalImage:@"Arrow-Normal-iPhone.png" 
                                                         selectedImage:@"Arrow-Selected-iPhone.png"
                                                                target:self 
                                                              selector:@selector(onBack:)];
        // Add menu image to menu
        CCMenu *back = [CCMenu menuWithItems: goBack, nil];
        
        // position menu in the bottom left of the screen (0,0 starts bottom left)
        back.position = ccp(32, 32);
        
        // Add menu to this scene
        [self addChild: back];        
    }
}

-(id)init {
    self = [super init];
    if (self != nil) {
        
        self.iPad = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad;
        
        if (self.iPad) {
            self.device = @"iPad";
        }
        else {
            self.device = @"iPhone";
        }
        
        int smallFont = [CCDirector sharedDirector].winSize.height / kFontScaleSmall;   
        CGSize screenSize = [CCDirector sharedDirector].winSize; 
        
        //Background
        CCSprite *background = 
        [CCSprite spriteWithFile:@"MainMenuBg-iPhone.png"];
        [background setPosition:ccp(screenSize.width/2, 
                                    screenSize.height/2)];
        [self addChild:background z:-5];
        CCSprite *background_layer1 = 
        [CCSprite spriteWithFile:@"MainMenuBg_Layer1-iPhone.png"];
        [background_layer1 setPosition:ccp(screenSize.width/2, 
                                           screenSize.height * 0.35f)];
        [self addChild:background_layer1 z:-4];

        // read in selected chapter number:
        GameData *gameData = [GameDataParser loadData];
        int selectedChapter = gameData.selectedChapter;
        
        
        // Read in selected chapter name (use to load custom background later):
        NSString *selectedChapterName = nil;        
        Chapters *selectedChapters = [ChapterParser loadData];
        for (Chapter *chapter in selectedChapters.chapters) {            
            if ([[NSNumber numberWithInt:chapter.number] intValue] == selectedChapter) {
                CCLOG(@"Selected Chapter is %@ (ie: number %i)", chapter.name, chapter.number);
                selectedChapterName = chapter.name;
            }
        }
        
        
        // Read in selected chapter levels
        CCMenu *levelMenu = [CCMenu menuWithItems: nil]; 
        NSMutableArray *overlay = [NSMutableArray new];
        
        Levels *selectedLevels = [LevelParser loadLevelsForChapter:gameData.selectedChapter];
        
        
        // Create a button for every level
        for (Level *level in selectedLevels.levels) {
            
            NSString *normal =   [NSString stringWithFormat:@"%@-Normal-%@.png", selectedChapterName, self.device];
            NSString *selected = [NSString stringWithFormat:@"%@-Selected-%@.png", selectedChapterName, self.device];
            
            CCMenuItemImage *item = [CCMenuItemImage itemFromNormalImage:normal
                                                           selectedImage:selected
                                                                  target:self 
                                                                selector:@selector(onPlay:)];
            [item setTag:level.number]; // note the number in a tag for later usage
            [item setIsEnabled:level.unlocked];  // ensure locked levels are inaccessible
            [levelMenu addChild:item];
            
            if (!level.unlocked) {
                
                NSString *overlayImage = [NSString stringWithFormat:@"Locked-%@.png", self.device];
                CCSprite *overlaySprite = [CCSprite spriteWithFile:overlayImage];
                [overlaySprite setTag:level.number];
                [overlay addObject:overlaySprite];
            }
            else {
                
                NSString *stars = [[NSNumber numberWithInt:level.stars] stringValue];
                NSString *overlayImage = [NSString stringWithFormat:@"%@Star-Normal-%@.png",stars, self.device];
                CCSprite *overlaySprite = [CCSprite spriteWithFile:overlayImage];
                [overlaySprite setTag:level.number];
                [overlay addObject:overlaySprite];
            }
            
        }
        
        [levelMenu alignItemsInColumns:
         [NSNumber numberWithInt:6],
         [NSNumber numberWithInt:6],
         [NSNumber numberWithInt:6],
         nil];
        
        // Move the whole menu up by a small percentage so it doesn't overlap the back button
        CGPoint newPosition = levelMenu.position;
        newPosition.y = newPosition.y + (newPosition.y / 10);
        [levelMenu setPosition:newPosition];
        
        [self addChild:levelMenu z:-3];
        
        
        // Create layers for star/padlock overlays & level number labels
        CCLayer *overlays = [[CCLayer alloc] init];
        CCLayer *labels = [[CCLayer alloc] init];
        
        
        for (CCMenuItem *item in levelMenu.children) {
            
            // create a label for every level
            
            CCLabelTTF *label = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%i",item.tag] 
                                                   fontName:@"Marker Felt" 
                                                   fontSize:smallFont];
            
            [label setAnchorPoint:item.anchorPoint];
            [label setPosition:item.position];
            [labels addChild:label];
            
            
            // set position of overlay sprites
            
            for (CCSprite *overlaySprite in overlay) {
                if (overlaySprite.tag == item.tag) {
                    [overlaySprite setAnchorPoint:item.anchorPoint];
                    [overlaySprite setPosition:item.position];
                    [overlays addChild:overlaySprite];
                }
            }
        }
        
        // Put the overlays and labels layers on the screen at the same position as the levelMenu
        
        [overlays setAnchorPoint:levelMenu.anchorPoint];
        [labels setAnchorPoint:levelMenu.anchorPoint];
        [overlays setPosition:levelMenu.position];
        [labels setPosition:levelMenu.position];
        [self addChild:overlays];
        [self addChild:labels];
        [overlays release];
        [labels release];
        
        
        // Add back button
        
        [self addBackButton]; 

        
    }
    return self;
}

@end
