//
//  HelloWorldScene.mm
//  SimpleBox2dScroller
//
//  Created by min on 1/13/11.
//  Copyright Min Kwon 2011. All rights reserved.
//


#import "GameplayScrollingLayer.h"
#import "CommonProtocols.h"
#import "Constants.h"
#import "CommonProtocols.h"
#import "Player.h"
#import "GameObject.h"

@interface GameplayScrollingLayer(Private) 
-(void) setupPhysicsWorld;
@end

@implementation GameplayScrollingLayer

-(void)connectControlsWithJoystick:(SneakyJoystick*)leftJoystick 
                     andJumpButton:(SneakyButton*)jumpButton 
                   andAttackButton:(SneakyButton*)attackButton {
    leftJoy = leftJoystick;
    jumpButt = jumpButton;
    attackButt = attackButton;
    [player setJoystick:leftJoy];
    [player setJumpButton:jumpButt];
    [player setAttackButton:attackButt];
    
}

-(void)setCurrentScene:(GameScene *)gameScene
{
    currentScene = gameScene;
}

-(void)restartGame
{
    [self deleteWorld];
    [currentScene removeDeathPopUp];
    [currentScene removeWinPopUp];
    [currentScene removePausePopUp];
    [self createNewWorld];
}

-(void)playNextGame
{
    
}

-(void)pauseGame
{
    [currentScene applyPausePopUp];
    CCLOG(@"pause performed");
    [self unscheduleUpdate];
}

-(void)unpauseGame
{
    [currentScene removePausePopUp];
    [self scheduleUpdate];
}

-(void)goHome
{
    [[GameManager sharedGameManager] runSceneWithID:kChapterSelectionScene];
}

- (void) makeBox2dObjAt:(CGPoint)p 
			   withSize:(CGPoint)size 
				dynamic:(BOOL)d 
			   rotation:(long)r 
			   friction:(long)f 
				density:(long)dens 
			restitution:(long)rest 
				  boxId:(int)boxId
      platformObjectTag:(GameObjectType)gameObjectType{
	
	// Define the dynamic body.
	//Set up a 1m squared box in the physics world
	b2BodyDef bodyDef;
//	bodyDef.angle = r;
	
	if(d)
		bodyDef.type = b2_dynamicBody;
	
	bodyDef.position.Set(p.x/PTM_RATIO, p.y/PTM_RATIO);
    
    GameObject *platform = [[GameObject alloc] init];
    [platform setGameObjectType:gameObjectType];
	bodyDef.userData = platform;
	
	b2Body *body = world->CreateBody(&bodyDef);
	
	// Define another box shape for our dynamic body.
    b2PolygonShape dynamicBox;
    dynamicBox.SetAsBox(size.x/2/PTM_RATIO, size.y/2/PTM_RATIO);
	
    // Define the dynamic body fixture.
    b2FixtureDef fixtureDef;
    fixtureDef.shape = &dynamicBox;	
    fixtureDef.density = dens;
    fixtureDef.friction = f;
    fixtureDef.restitution = rest;
    switch (gameObjectType) {
        case kGameObjectStaticPlatform:
            fixtureDef.filter.groupIndex = kGIndexFilterStaticPlatformerTagValue;
            break;
        case kGameObjectRedPlatform:
            fixtureDef.filter.groupIndex = kGIndexFilterRedPlatformerTagValue;
            break;
        case kGameObjectBlackPlatform:
            fixtureDef.filter.groupIndex = kGIndexFilterBlackPlatformerTagValue;
            break;
        case kGameObjectGoal:
            fixtureDef.filter.groupIndex = kGIndexFilterGoalTagValue;
            break;
        default:
            break;
    }
    body->CreateFixture(&fixtureDef);
    
}



- (void) drawCollisionTiles {
	CCTMXObjectGroup *objects = [tileMapNode objectGroupNamed:@"StaticPlatform"];
	NSMutableDictionary * objPoint;
	
	int x, y, w, h;	
	for (objPoint in [objects objects]) {
		x = [[objPoint valueForKey:@"x"] intValue];
		y = [[objPoint valueForKey:@"y"] intValue];
		w = [[objPoint valueForKey:@"width"] intValue];
		h = [[objPoint valueForKey:@"height"] intValue];	
		
		CGPoint _point=ccp(x+w/2,y+h/2);
		CGPoint _size=ccp(w,h);
		
		[self makeBox2dObjAt:_point 
					withSize:_size 
					 dynamic:false 
					rotation:0 
					friction:1.5f 
					 density:0.0f 
				 restitution:0 
					   boxId:-1
           platformObjectTag:kGameObjectStaticPlatform];
	}
    
    objects = [tileMapNode objectGroupNamed:@"RedPlatform"];
    
	for (objPoint in [objects objects]) {
		x = [[objPoint valueForKey:@"x"] intValue];
		y = [[objPoint valueForKey:@"y"] intValue];
		w = [[objPoint valueForKey:@"width"] intValue];
		h = [[objPoint valueForKey:@"height"] intValue];	
		
		CGPoint _point=ccp(x+w/2,y+h/2);
		CGPoint _size=ccp(w,h);
		
		[self makeBox2dObjAt:_point 
					withSize:_size 
					 dynamic:false 
					rotation:0 
					friction:1.5f 
					 density:0.0f 
				 restitution:0 
					   boxId:-1
           platformObjectTag:kGameObjectRedPlatform];
	}
    
    objects = [tileMapNode objectGroupNamed:@"BlackPlatform"];
    
	for (objPoint in [objects objects]) {
		x = [[objPoint valueForKey:@"x"] intValue];
		y = [[objPoint valueForKey:@"y"] intValue];
		w = [[objPoint valueForKey:@"width"] intValue];
		h = [[objPoint valueForKey:@"height"] intValue];	
		
		CGPoint _point=ccp(x+w/2,y+h/2);
		CGPoint _size=ccp(w,h);
		
		[self makeBox2dObjAt:_point 
					withSize:_size 
					 dynamic:false 
					rotation:0 
					friction:1.5f 
					 density:0.0f 
				 restitution:0 
					   boxId:-1
           platformObjectTag:kGameObjectBlackPlatform];
	}
    
    objects = [tileMapNode objectGroupNamed:@"finishSign"];
    
	for (objPoint in [objects objects]) {
		x = [[objPoint valueForKey:@"x"] intValue];
		y = [[objPoint valueForKey:@"y"] intValue];
		w = [[objPoint valueForKey:@"width"] intValue];
		h = [[objPoint valueForKey:@"height"] intValue];	
		
		CGPoint _point=ccp(x+w/2,y+h/2);
		CGPoint _size=ccp(w,h);
		
		[self makeBox2dObjAt:_point 
					withSize:_size 
					 dynamic:false 
					rotation:0 
					friction:1.5f 
					 density:0.0f 
				 restitution:0 
					   boxId:-1
           platformObjectTag:kGameObjectGoal];
	}


}

- (void) addScrollingBackgroundWithTileMap {
	tileMapNode = [CCTMXTiledMap tiledMapWithTMXFile:@"scroller.tmx"];
	tileMapNode.anchorPoint = ccp(0, 0);
	[self addChild:tileMapNode];
}

- (void) createNewWorld
{
    screenSize = [CCDirector sharedDirector].winSize;
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"Player_iPhone.plist"];          // 1
    sceneSpriteBatchNode = [CCSpriteBatchNode batchNodeWithFile:@"Player_iPhone.png"];// 2
    
    [self addChild:sceneSpriteBatchNode z:20]; // 3
    
    
    [self setupPhysicsWorld];		
    [self addScrollingBackgroundWithTileMap];
    [self drawCollisionTiles];
    
    player = [[Player alloc] initWithSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"Idle_black.png"]]; // 5
    //[player setJoystick:nil];
    //[player setJumpButton:nil];
    //[player setAttackButton:nil];
    player.position = ccp(100.0f, 180.0f);
    [player createBox2dObject:world];
    [player setContactListener:contactListener];
    
    
    [self addChild:player];
    [player setJoystick:leftJoy];
    [player setJumpButton:jumpButt];
    [player setAttackButton:attackButt];

    
    // Start main game loop
    [self unscheduleUpdate];
    [self scheduleUpdate];

}

- (void) deleteWorld
{
    delete world;
	world = NULL;
	
	delete m_debugDraw;
    [self removeChild:player cleanup:YES];
    [self removeChild:sceneSpriteBatchNode cleanup:YES];
}

// initialize your instance here
-(id) init
{
	if( (self=[super init])) {
		
		// enable touches
		self.isTouchEnabled = YES;
				
        [self createNewWorld];
    }
	return self;
}

-(void) setupPhysicsWorld {
    b2Vec2 gravity = b2Vec2(0.0f, -9.8f);
    bool doSleep = true;
    world = new b2World(gravity, doSleep);
    
    m_debugDraw = new GLESDebugDraw(PTM_RATIO);
    world->SetDebugDraw(m_debugDraw);
    uint32 flags = 0;
    flags += b2DebugDraw::e_shapeBit;
    m_debugDraw->SetFlags(flags);

    contactListener = new ContactListener();
    world->SetContactListener(contactListener);
    contactFiltering = new ContactFiltering();
    world->SetContactFilter(contactFiltering);
}

-(void) draw {
	glDisable(GL_TEXTURE_2D);
	glDisableClientState(GL_COLOR_ARRAY);
	glDisableClientState(GL_TEXTURE_COORD_ARRAY);
	
	world->DrawDebugData();
	
	// restore default GL states
	glEnable(GL_TEXTURE_2D);
	glEnableClientState(GL_COLOR_ARRAY);
	glEnableClientState(GL_TEXTURE_COORD_ARRAY);
}

- (void) update:(ccTime)dt {
	//It is recommended that a fixed time step is used with Box2D for stability
	//of the simulation, however, we are using a variable time step here.
	//You need to make an informed choice, the following URL is useful
	//http://gafferongames.com/game-physics/fix-your-timestep/
	
	int32 velocityIterations = 8;
	int32 positionIterations = 1;
	
	// Instruct the world to perform a single step of simulation. It is
	// generally best to keep the time step and iterations fixed.
	world->Step(dt, velocityIterations, positionIterations);
	
	
	//Iterate over the bodies in the physics world
	for (b2Body* b = world->GetBodyList(); b; b = b->GetNext()) {
		if (b->GetUserData() != NULL) {
			//Synchronize the AtlasSprites position and rotation with the corresponding body
			CCSprite *myActor = (CCSprite*)b->GetUserData();
			myActor.position = CGPointMake( b->GetPosition().x * PTM_RATIO, 
										   b->GetPosition().y * PTM_RATIO);
			myActor.rotation = -1 * CC_RADIANS_TO_DEGREES(b->GetAngle());
		}	
	}	
	
	b2Vec2 pos = [player body]->GetPosition();
    
	CGPoint newPos = ccp(-1 * pos.x * PTM_RATIO + 100, self.position.y * PTM_RATIO);	
    //CCLOG(@"x = %f, y = %f",pos.x,pos.y);
    if (pos.y < -3.0f) {
        [currentScene applyDeathPopUp];
        [self unscheduleUpdate];
    }
    if (contactListener->isGoal) {
        [currentScene applyWinPopUp];
        [self unscheduleUpdate];
    }
	[self setPosition:newPos];
    
    [player updateStateWithDeltaTime:dt];
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	delete world;
	world = NULL;
	
	delete m_debugDraw;
	
	// don't forget to call "super dealloc"
	[super dealloc];
}
@end