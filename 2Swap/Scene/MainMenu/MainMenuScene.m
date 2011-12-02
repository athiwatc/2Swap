//  MainMenuScene.m
//  SpaceViking
//
#import "MainMenuScene.h"

@implementation MainMenuScene
-(id)init {
    self = [super init];
    if (self != nil) {
        mainMenuLayer = [MainMenuLayer node];
        [self addChild:mainMenuLayer];
    }
    return self;
}
@end
