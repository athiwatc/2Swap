//
//  StoryModeScene.m
//  2Swap
//
//  Created by Wairung Tiranalinvit on 7/11/11.
//  Copyright 2011 Kasetsart University. All rights reserved.
//

#import "StoryModeScene.h"


@implementation StoryModeScene

+ (id) scene
{
    CCScene* scene = [CCScene node];
    CCLayer* layer = [StoryModeScene node];
    [scene addChild:layer];
    return scene;
}

- (id) init
{
    if ((self = [super init]))
    {
        CCLOG(@"%@: %@", NSStringFromSelector(_cmd), self);
		CCSprite* level1 = [CCSprite spriteWithFile:@"Story_mode_but.png"];
		CCLabelTTF* label = [CCLabelTTF labelWithString:@"Story Mode Scene" fontName:@"Marker Felt" fontSize:64];
		label.color = ccRED;
		CGSize size = [[CCDirector sharedDirector] winSize];
		label.position = CGPointMake(size.width / 2, size.height / 2);
        level1.position = CGPointMake(size.width / 2, size.height / 2 + 100);
		[self addChild:label];
        [self addChild:level1];
		
		self.isTouchEnabled = YES;
    }
    return self;
}

- (void) dealloc
{
    [super dealloc];
}

@end
