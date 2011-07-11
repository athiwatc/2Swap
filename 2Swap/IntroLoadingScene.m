//
//  IntroLoadingScene.m
//  2Swap
//
//  Created by Wairung Tiranalinvit on 7/11/11.
//  Copyright 2011 Kasetsart University. All rights reserved.
//

#import "IntroLoadingScene.h"
#import "MainMenuScene.h"

@implementation IntroLoadingScene

+ (id) scene
{
    CCScene* scene = [CCScene node];
    CCLayer* layer = [IntroLoadingScene node];
    [scene addChild:layer];
    return scene;
}

- (id) init
{
    if ((self = [super init]))
    {
        CCLOG(@"%@: %@", NSStringFromSelector(_cmd), self);
		
		CCLabelTTF* label = [CCLabelTTF labelWithString:@"Intro Loading ...." fontName:@"Marker Felt" fontSize:64];
		label.color = ccBLUE;
		CGSize size = [[CCDirector sharedDirector] winSize];
		label.position = CGPointMake(size.width / 2, size.height / 2);
		[self addChild:label];
		
		self.isTouchEnabled = YES;
    }
    return self;
}

- (void) dealloc
{
    //dealloc scene
    [super dealloc];
}

- (void) ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    CCTransitionFade* transition = [CCTransitionFade transitionWithDuration:2 scene:[MainMenuScene scene]];
    [[CCDirector sharedDirector] replaceScene:transition];
}

- (void) onEnter
{
    [super onEnter];
}

- (void) onEnterTransitionDidFinish
{
    [super onEnterTransitionDidFinish];
}

- (void) onExit
{
    [super onExit];
}

@end
