//  StaticBackgroundLayer.m
//  SpaceViking
#import "StaticBackgroundLayer.h"

@implementation StaticBackgroundLayer
-(id)init { 
    self = [super init];
    if (self != nil) {
        CGSize screenSize = [CCDirector sharedDirector].winSize; 
        CCSprite *backgroundImage;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            // Indicates game is running on iPad
            backgroundImage = 
            [CCSprite spriteWithFile:@"chap9_scrolling1.png"];
        } else {
            backgroundImage = 
            [CCSprite spriteWithFile:@"chap9_scrolling1iPhone.png"];
        }
        
        [backgroundImage setPosition:ccp(screenSize.width/2.0f, 
                                         screenSize.height/2.0f)];
        [self addChild:backgroundImage];
    }
    return self;
}
@end

