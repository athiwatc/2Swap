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

@class DeathPopUpLayer;
@class GameplayScrollingLayer;
@class WinPopUpLayer;

@interface GameScene : CCScene {
    GameControlLayer *controlLayer;
    DeathPopUpLayer *deathpop;
    WinPopUpLayer *winpop;
    GameplayScrollingLayer *scrollingLayer;
}

- (void) applyDeathPopUp;
- (void) removeDeathPopUp;
- (void) applyWinPopUp;
- (void) removeWinPopUp;


@end
