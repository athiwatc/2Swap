//
//  LevelLoader.m
//  2Swap
//
//  Created by Wairung Tiranalinvit on 1/10/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import "LevelManager.h"
#import "GameData.h"
#import "GameDataParser.h"


@implementation LevelManager

- (BOOL) hasNextLevel
{
    switch (selectedChapter) {
        case 1:
            return selectedLevel+1 <= 18;
            break;
            
        default:
            break;
    }
    return NO;
}

- (void) goNextLevel
{
    GameData *gameData = [GameDataParser loadData];
    if ([self hasNextLevel]) {
        [gameData setSelectedLevel:selectedLevel+1];
    }
    [GameDataParser saveData:gameData];
}

- (NSString*) getLevelName
{
    [self refresh];
    switch (selectedChapter) {
        case 1:
            switch (selectedLevel) {
                case 1:
                    return @"Chapter - Level 1";
                    break;
                    
                case 2:
                    return @"Chapter - Level 2";
                    break;
                    
                case 3:
                    return @"Chapter - Level 3";
                    break;
                    
                default:
                    break;
            }
            
        default:
            break;
    }
    return @"";
}

- (NSString*) getLevelTMXFileName
{
    [self refresh];
    switch (selectedChapter) {
        case 1:
            switch (selectedLevel) {
                case 1:
                    return @"ch1-level1.tmx";
                    break;
                
                case 2:
                    return @"ch1-level2.tmx";
                    break;
                    
                default:
                    break;
            }
            
        default:
            break;
    }
    return @"";
}

- (id) init
{
    self = [super init];
    if (self != nil) {
        GameData *gameData = [GameDataParser loadData];
        selectedChapter = gameData.selectedChapter;
        selectedLevel = gameData.selectedLevel;
    }
    return self;
}

- (void) refresh {
    GameData *gameData = [GameDataParser loadData];
    selectedChapter = gameData.selectedChapter;
    selectedLevel = gameData.selectedLevel;
}

- (void) dealloc
{
    [super dealloc];
}

@end
