//
//  IntroScene.m
//  2Swap
//
//  Created by Wairung Tiranalinvit on 7/11/11.
//  Copyright 2011 Kasetsart University. All rights reserved.
//

#import "IntroScene.h"


@implementation IntroScene

+ (id) scene
{
    CCScene* scene = [CCScene node];
    CCLayer* layer = [IntroScene node];
    [scene addChild:layer];
    return scene;
}

- (id) init
{
    if ((self = [super init]))
    {
        CCLOG(@"%@: %@", NSStringFromSelector(_cmd), self);
		
		CCLabelTTF* label = [CCLabelTTF labelWithString:@"Intro Scene" fontName:@"Marker Felt" fontSize:64];
		label.color = ccYELLOW;
		CGSize size = [[CCDirector sharedDirector] winSize];
		label.position = CGPointMake(size.width / 2, size.height / 2);
		[self addChild:label];
		
		self.isTouchEnabled = YES;
    }
    return self;
}

- (void) dealloc
{
    [super dealloc];
}

@end
