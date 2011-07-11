//
//  LoadingScene.h
//  2Swap
//
//  Created by Wairung Tiranalinvit on 7/11/11.
//  Copyright 2011 Kasetsart University. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

typedef enum
{
    TargetSceneINVALID = 0,
    TargetSceneIntroScene,
    TargetSceneMainMenuScene,
    TargetSceneMAX,
} TargetScenes;


@interface LoadingScene : CCScene {
    TargetScenes targetScene_;
}

+(id) sceneWithTargetScene:(TargetScenes)targetScene;
-(id) initWithTargetScene:(TargetScenes)targetScene;

@end
