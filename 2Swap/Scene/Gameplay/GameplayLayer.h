
#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "SneakyJoystick.h"
#import "SneakyButton.h"
#import "SneakyButtonSkinnedBase.h"
#import "SneakyJoystickSkinnedBase.h"
#import "Constants.h"
#import "CommonProtocols.h"

@interface GameplayLayer : CCLayer <GameplayLayerDelegate> { 
    CCSprite *vikingSprite;
    SneakyJoystick *leftJoystick;  
    SneakyButton *jumpButton;  
    SneakyButton *attackButton; 
    CCSpriteBatchNode *sceneSpriteBatchNode;
}

@end
