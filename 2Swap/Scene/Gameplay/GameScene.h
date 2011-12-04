//
//  HelloWorldScene.h
//  SimpleBox2dScroller
//
//  Created by min on 1/13/11.
//  Copyright Min Kwon 2011. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#import "Box2D.h"
#import "GLES-Render.h"
#import "ContactListener.h"

@class Player;

@interface GameScene : CCLayer
{
    CGSize screenSize;
	b2World* world;
	GLESDebugDraw *m_debugDraw;
	CCTMXTiledMap *tileMapNode;	
    Player *player;
    ContactListener *contactListener;
}

+(id) scene;
@end
