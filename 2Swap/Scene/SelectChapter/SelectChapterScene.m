//
//  SelectChapterScene.m
//  2Swap
//
//  Created by Wairung Tiranalinvit on 11/15/54 BE.
//  Copyright 2554 __MyCompanyName__. All rights reserved.
//

#import "SelectChapterScene.h"
#import "SelectChapterLayer.h"

@implementation SelectChapterScene

-(id)init {
	self = [super init];
	if (self != nil) {
		SelectChapterLayer *myLayer = [SelectChapterLayer node];
		[self addChild:myLayer];
		
	}
	return self;
}
@end
