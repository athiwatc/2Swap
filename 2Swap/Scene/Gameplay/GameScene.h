//  GameScene2.h
//  SpaceViking
//
#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Constants.h"
#import "GameControlLayer.h"
#import "GameplayScrollingLayer.h"
#import "StaticBackgroundLayer.h"

@interface GameScene : CCScene {
    GameControlLayer *controlLayer;
}
@end
