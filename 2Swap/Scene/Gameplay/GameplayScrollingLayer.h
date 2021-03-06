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
#import "GameControlLayer.h"
#import "ContactFiltering.h"
#import "GameScene.h"
#import "GameManager.h"
#import "LevelManager.h"

@class Player;
@class GameScene;

@interface GameplayScrollingLayer : CCLayer
{
    CGSize screenSize;
    float max_width_map;
    float max_height_map;
    float player_size_offset;
    int mid_screen_pos;
    
    CCSpriteBatchNode *sceneSpriteBatchNode;
	b2World* world;
	GLESDebugDraw *m_debugDraw;
	CCTMXTiledMap *tileMapNode;	
    Player *player;
    ContactListener *contactListener;
    ContactFiltering *contactFiltering;
    CCMenu *sceneSelectMenu;
    CCMenu *mainMenu;
    GameScene *currentScene;
    
    SneakyJoystick *leftJoy;
    SneakyButton *jumpButt;
    SneakyButton *attackButt;

    LevelManager *level_manager;
}


-(void)connectControlsWithJoystick:(SneakyJoystick*)leftJoystick 
                     andJumpButton:(SneakyButton*)jumpButton 
                   andAttackButton:(SneakyButton*)attackButton;    
-(void)createNewWorld;
-(void)deleteWorld;
-(void)pauseGame;
-(void)unpauseGame;
-(void)restartGame;
-(void)playNextGame;
-(void)goHome;
-(void)setCurrentScene : (GameScene*) gameScene;
-(void) setupLevel : (LevelManager*) levelManager;

@end
