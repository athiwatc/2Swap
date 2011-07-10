//
//  MainMenuScene.m
//  2Swap
//
//  Created by Wairung Tiranalinvit on 7/11/11.
//  Copyright 2011 Kasetsart University. All rights reserved.
//

#import "MainMenuScene.h"


@implementation MainMenuScene

+ (id) scene
{
    CCScene* scene = [CCScene node];
    CCLayer *layer = [CCLayer node];
    [scene addChild:layer];
    return scene;
}

@end
