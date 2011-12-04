//
//  GameManager.m
//  2Swap
//
//  Created by Wairung Tiranalinvit on 11/4/54 BE.
//  Copyright 2554 __MyCompanyName__. All rights reserved.
//

#import "GameManager.h"
#import "MainMenuScene.h"
#import "OptionsScene.h"
#import "CreditsScene.h"
#import "SelectChapterScene.h"
#import "LevelSelectScene.h"
#import "GameScene.h"

@implementation GameManager
static GameManager* _sharedGameManager = nil;                      // 1
@synthesize isMusicON;
@synthesize isSoundEffectsON;
@synthesize hasPlayerDied;

+(GameManager*)sharedGameManager {
    @synchronized([GameManager class])                             // 2
    {
        if(!_sharedGameManager)                                    // 3
            [[self alloc] init]; 
        return _sharedGameManager;                                 // 4
    }
    return nil; 
}

+(id)alloc 
{
    @synchronized ([GameManager class])                            // 5
    {
        NSAssert(_sharedGameManager == nil,
                 @"Attempted to allocated a second instance of the Game Manager singleton");                                          // 6
        _sharedGameManager = [super alloc];
        return _sharedGameManager;                                 // 7
    }
    return nil;  
}

-(id)init {                                                        // 8
    self = [super init];
    if (self != nil) {
        // Game Manager initialized
        CCLOG(@"Game Manager Singleton, init");
        isMusicON = YES;
        isSoundEffectsON = YES;
        hasPlayerDied = NO;
        currentScene = kNoSceneUninitialized;
    }
    return self;
}
-(void)runSceneWithID:(SceneTypes)sceneID {
    SceneTypes oldScene = currentScene;
    currentScene = sceneID;
    
    id sceneToRun = nil;
    switch (sceneID) {
        case kMainMenuScene: 
            sceneToRun = [MainMenuScene node];
            break;
        case kOptionsScene:
            sceneToRun = [OptionsScene node];
            break;
        case kCreditsScene:
            sceneToRun = [CreditsScene node];
            break;
        case kChapterSelectionScene:
            sceneToRun = [SelectChapterScene node];
            break;
        case kLevelSelectionScene:
            sceneToRun = [LevelSelectScene node];
            break;
        case kIntroScene:
            break;
        case kLevelCompleteScene:
            break;
        case kGameLevel1: 
            sceneToRun = [GameScene node];
            break;
        case kGameLevel2:
            // Placeholder for Level 2
            break;
        case kGameLevel3:
            // Placeholder for Level 3
            break;
        case kGameLevel4:
            // Placeholder for Level 4
            break;
        case kGameLevel5:
            // Placeholder for Level 5
            break;
        case kCutSceneForLevel2:
            // Placeholder for Platform Level
            break;
            
        default:
            CCLOG(@"Unknown ID, cannot switch scenes");
            return;
            break;
    }
    if (sceneToRun == nil) {
        // Revert back, since no new scene was found
        currentScene = oldScene;
        return;
    }
    
    // Menu Scenes have a value of < 100
    if (sceneID < 100) {
        if (UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPad) { 
            CGSize screenSize = [CCDirector sharedDirector].winSizeInPixels; 
            if (screenSize.width == 960.0f) {
                // iPhone 4 Retina
                [sceneToRun setScaleX:0.9375f];
                [sceneToRun setScaleY:0.8333f];
                CCLOG(@"GameMgr:Scaling for iPhone 4 (retina)");
                
            } else {
                /*[sceneToRun setScaleX:0.4688f];
                [sceneToRun setScaleY:0.4166f];*/
                CCLOG(@"GameMgr:Scaling for iPhone 3GS or older (non-retina)");
                
            }
        }
    }
    
    if ([[CCDirector sharedDirector] runningScene] == nil) {
        [[CCDirector sharedDirector] runWithScene:sceneToRun];
        
    } else {
        
        [[CCDirector sharedDirector] replaceScene:sceneToRun];
    }    
}

-(CGSize)getDimensionsOfCurrentScene {
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    CGSize levelSize;
    switch (currentScene) {
        case kMainMenuScene: 
        case kOptionsScene:
        case kCreditsScene:
        case kIntroScene:
        case kLevelCompleteScene:
        case kGameLevel1: 
            levelSize = screenSize;
            break;
        case kGameLevel2:
            levelSize = CGSizeMake(screenSize.width * 4.0f, screenSize.height);
            break;
            
        default:
            CCLOG(@"Unknown Scene ID, returning default size");
            levelSize = screenSize;
            break;
    }
    return levelSize;
}

-(void)openSiteWithLinkType:(LinkTypes)linkTypeToOpen {
    NSURL *urlToOpen = nil;
    if (linkTypeToOpen == kLinkTypeBookSite) {
        CCLOG(@"Opening Book Site");
        urlToOpen = 
        [NSURL URLWithString:
         @"http://www.google.com"];
    } else if (linkTypeToOpen == kLinkTypeDeveloperSiteRod) {
        CCLOG(@"Opening Developer Site for Rod");
        urlToOpen = [NSURL URLWithString:@"http://www.prop.gr"];
    } else if (linkTypeToOpen == kLinkTypeDeveloperSiteRay) {
        CCLOG(@"Opening Developer Site for Ray");
        urlToOpen = 
        [NSURL URLWithString:@"http://www.raywenderlich.com/"];
    } else if (linkTypeToOpen == kLinkTypeArtistSite) {
        CCLOG(@"Opening Artist Site");
        urlToOpen = [NSURL URLWithString:@"http://EricStevensArt.com"];
    } else if (linkTypeToOpen == kLinkTypeMusicianSite) {
        CCLOG(@"Opening Musician Site");
        urlToOpen = 
        [NSURL URLWithString:@"http://www.mikeweisermusic.com/"];
    } else {
        CCLOG(@"Defaulting to Cocos2DBook.com Blog Site");
        urlToOpen = 
        [NSURL URLWithString:@"http://www.cocos2dbook.com"];
    }
    
    if (![[UIApplication sharedApplication] openURL:urlToOpen]) {
        CCLOG(@"%@%@",@"Failed to open url:",[urlToOpen description]);
        [self runSceneWithID:kMainMenuScene];
    }
}
@end
