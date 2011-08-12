//
//  GameScene.m
//  2Swap
//
//  Created by Wairung Tiranalinvit on 8/12/54 BE.
//  Copyright 2554 Kasetsart University. All rights reserved.
//

#import "GameScene.h"
#import "Player.h"
#import "JoyLayer.h"
#import "ParallaxBackground.h"

@implementation GameScene

static GameScene* instanceOfGameScene;
+(GameScene*) sharedGameScene
{
	NSAssert(instanceOfGameScene != nil, @"GameScene instance not yet initialized!");
	return instanceOfGameScene;
}

+(id) scene
{
	CCScene* scene = [CCScene node];
	GameScene* layer = [GameScene node];
	[scene addChild:layer z:0 tag:GameSceneLayerTagGame];
	JoyLayer* inputLayer = [JoyLayer node];
	[scene addChild:inputLayer z:1 tag:GameSceneLayerTagInput];
	return scene;
}

-(id) init
{
	if ((self = [super init]))
	{
		/*instanceOfGameScene = self;
		
		// Load all of the game's artwork up front.
		CCSpriteFrameCache* frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
		[frameCache addSpriteFramesWithFile:@"game-art.plist"];
		
		CGSize screenSize = [[CCDirector sharedDirector] winSize];
		
		ParallaxBackground* background = [ParallaxBackground node];
		[self addChild:background z:-1];
		
		Player* player = [Player player];
		player.position = CGPointMake([ship contentSize].width / 2, screenSize.height / 2);
		[self addChild:player z:0 tag:GameSceneNodeTagPlayer];*/
	}
	return self;
}

-(void) dealloc
{
	instanceOfGameScene = nil;
	
	// don't forget to call "super dealloc"
	[super dealloc];
}

@end
