//
//  GameManager.h
//  2Swap
//
//  Created by Wairung Tiranalinvit on 11/4/54 BE.
//  Copyright 2554 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"
#import "cocos2d.h"

@interface GameManager : NSObject {
    BOOL isMusicOn;
    BOOL isSoundEffectsON;
    BOOL hasPlayerDied;
    SceneTypes currentScene;
    int curLevel;
    long curScore;
    long scoreFirstStar;
    long scoreSecondStar;
    long scoreThridStar;
}

@property (readwrite) BOOL isMusicON;
@property (readwrite) BOOL isSoundEffectsON;
@property (readwrite) BOOL hasPlayerDied;
@property (readwrite) int curLevel;
@property (readwrite) long curScore;
@property (readwrite) long scoreFirstStar;
@property (readwrite) long scoreSecondStar;
@property (readwrite) long scoreThridStar;

+(GameManager*)sharedGameManager;
-(void)runSceneWithID:(SceneTypes)sceneID;
-(void)openSiteWithLinkType:(LinkTypes)linkTypeToOpen;

@end
