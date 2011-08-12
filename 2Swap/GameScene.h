//
//  GameScene.h
//  2Swap
//
//  Created by Wairung Tiranalinvit on 8/12/54 BE.
//  Copyright 2554 Kasetsart University. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Player.h"
typedef enum
{
	GameSceneLayerTagGame = 1,
	GameSceneLayerTagInput,
	
} GameSceneLayerTags;


@interface GameScene : CCLayer {
    
}

+(id) scene;
+(GameScene*) sharedGameScene;

@end
