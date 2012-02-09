//
//  LevelLoader.h
//  2Swap
//
//  Created by Wairung Tiranalinvit on 1/10/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface LevelManager : NSObject {
    
    int selectedChapter;
    int selectedLevel;
}

- (BOOL) hasNextLevel;
- (void) goNextLevel;
- (void) refresh;
- (NSString*) getLevelTMXFileName;
- (NSString*) getLevelName;
@end
