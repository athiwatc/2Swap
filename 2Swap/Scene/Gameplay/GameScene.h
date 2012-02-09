//  GameScene2.h
//  SpaceViking
//
#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Constants.h"
#import "GameControlLayer.h"
#import "GameplayScrollingLayer.h"
#import "StaticBackgroundLayer.h"
#import "DeathPopUpLayer.h"
#import "WinPopUpLayer.h"
#import "PausePopUpLayer.h"
#import "HUDLayer.h"
#import "LevelManager.h"

@class PausePopUpLayer;
@class DeathPopUpLayer;
@class GameplayScrollingLayer;
@class WinPopUpLayer;
@class LevelManager;

@interface GameScene : CCScene {
    GameControlLayer *controlLayer;
    DeathPopUpLayer *deathpop;
    WinPopUpLayer *winpop;
    GameplayScrollingLayer *scrollingLayer;
    PausePopUpLayer *pausepop;
    LevelManager *levelmanager;
}

- (void) applyDeathPopUp;
- (void) removeDeathPopUp;
- (void) applyWinPopUp;
- (void) removeWinPopUp;
- (void) applyPausePopUp;
- (void) removePausePopUp;


@end
