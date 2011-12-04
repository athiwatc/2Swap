//
//  HelloWorldScene.mm
//  SimpleBox2dScroller
//
//  Created by min on 1/13/11.
//  Copyright Min Kwon 2011. All rights reserved.
//


#import "GameScene.h"
#import "Constants.h"
#import "Player.h"
#import "GameObject.h"

@interface GameScene(Private) 
-(void) setupPhysicsWorld;
@end

@implementation GameScene

+(id) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	GameScene *layer = [GameScene node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

- (void) makeBox2dObjAt:(CGPoint)p 
			   withSize:(CGPoint)size 
				dynamic:(BOOL)d 
			   rotation:(long)r 
			   friction:(long)f 
				density:(long)dens 
			restitution:(long)rest 
				  boxId:(int)boxId {
	
	// Define the dynamic body.
	//Set up a 1m squared box in the physics world
	b2BodyDef bodyDef;
//	bodyDef.angle = r;
	
	if(d)
		bodyDef.type = b2_dynamicBody;
	
	bodyDef.position.Set(p.x/PTM_RATIO, p.y/PTM_RATIO);
    
    GameObject *platform = [[GameObject alloc] init];
    [platform setType:kGameObjectPlatform];
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
	body->CreateFixture(&fixtureDef);
}



- (void) drawCollisionTiles {
	CCTMXObjectGroup *objects = [tileMapNode objectGroupNamed:@"Collision"];
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
					   boxId:-1];
	}
}

- (void) addScrollingBackgroundWithTileMap {
	tileMapNode = [CCTMXTiledMap tiledMapWithTMXFile:@"scroller.tmx"];
	tileMapNode.anchorPoint = ccp(0, 0);
	[self addChild:tileMapNode];
}


// initialize your instance here
-(id) init
{
	if( (self=[super init])) {
		
		// enable touches
		self.isTouchEnabled = YES;
				
		screenSize = [CCDirector sharedDirector].winSize;
		[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];   
		
        [self setupPhysicsWorld];
		
		[self addScrollingBackgroundWithTileMap];
		[self drawCollisionTiles];
		
        player = [Player spriteWithFile:@"Icon-Small.png"];        
        player.position = ccp(100.0f, 180.0f);
        [player createBox2dObject:world];
		
		[self addChild:player];
		
        // Start main game loop
		[self scheduleUpdate];
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
	CGPoint newPos = ccp(-1 * pos.x * PTM_RATIO + 50, self.position.y * PTM_RATIO);	
	[self setPosition:newPos];
}

-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {    
    CGPoint location = [touch locationInView:[touch view]];
    location = [[CCDirector sharedDirector] convertToGL:location];
    if (location.x <= screenSize.width / 2) {
        [player moveRight];        
    } else {
        [player jump];
    }
	return TRUE;
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