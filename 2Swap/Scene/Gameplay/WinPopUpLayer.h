//  GameControlLayer.h
//  SpaceViking
//
#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GameplayScrollingLayer.h"

@class GameplayScrollingLayer;

@interface WinPopUpLayer : CCLayer {
    GameplayScrollingLayer *game;
    CGSize screenSize;
}

- (void) setGame : (GameplayScrollingLayer*) gamei;
@end