//
//  SelectChapterScene.m
//  2Swap
//
//  Created by Wairung Tiranalinvit on 11/15/54 BE.
//  Copyright 2554 __MyCompanyName__. All rights reserved.
//

#import "LevelSelectScene.h"
#import "LevelSelectLayer.h"

@implementation LevelSelectScene

-(id)init {
	self = [super init];
	if (self != nil) {
		LevelSelectLayer *myLayer = [LevelSelectLayer node];
		[self addChild:myLayer];
		
	}
	return self;
}
@end
