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

@class DeathPopUpLayer;
@class GameplayScrollingLayer;

@interface GameScene : CCScene {
    GameControlLayer *controlLayer;
    DeathPopUpLayer *deathpop;
    GameplayScrollingLayer *scrollingLayer;
}

- (void) applyDeathPopUp;
- (void) removeDeathPopUp;

@end
