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

@class PausePopUpLayer;
@class DeathPopUpLayer;
@class GameplayScrollingLayer;
@class WinPopUpLayer;

@interface GameScene : CCScene {
    GameControlLayer *controlLayer;
    DeathPopUpLayer *deathpop;
    WinPopUpLayer *winpop;
    GameplayScrollingLayer *scrollingLayer;
    PausePopUpLayer *pausepop;
}

- (void) applyDeathPopUp;
- (void) removeDeathPopUp;
- (void) applyWinPopUp;
- (void) removeWinPopUp;
- (void) applyPausePopUp;
- (void) removePausePopUp;


@end
