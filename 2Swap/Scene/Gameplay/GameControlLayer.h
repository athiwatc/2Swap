//  GameControlLayer.h
//  SpaceViking
//
#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "SneakyJoystick.h"
#import "SneakyJoystickSkinnedBase.h"
#import "SneakyButton.h"
#import "SneakyButtonSkinnedBase.h"

@interface GameControlLayer : CCLayer {
    SneakyJoystick *leftJoystick;
    SneakyButton *jumpButton;
    SneakyButton *attackButton;
    
}
@property (nonatomic, readonly) SneakyJoystick *leftJoystick;
@property (nonatomic, readonly) SneakyButton *jumpButton;
@property (nonatomic, readonly) SneakyButton *attackButton;
@end