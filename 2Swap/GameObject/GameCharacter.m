//  GameCharacter.m
//  SpaceViking

#import "GameCharacter.h"

@implementation GameCharacter
@synthesize characterHealth;
@synthesize characterState; 

-(void) dealloc { 
    [super dealloc];
}

-(int)getWeaponDamage {
    // Default to zero damage
    CCLOG(@"getWeaponDamage should be overriden");
    return 0;
}

-(void)checkAndClampSpritePosition { 
    CGPoint currentSpritePosition = [self position];
    
    CGSize levelSize = [[GameManager sharedGameManager] 
                        getDimensionsOfCurrentScene];
    float xOffset;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
         // Clamp for the iPad
        xOffset = 30.0f;
    } else {
         // Clamp for iPhone, iPhone 4, or iPod touch
        xOffset = 24.0f;
    }

    if (currentSpritePosition.x < xOffset) {
        [self setPosition:ccp(xOffset, currentSpritePosition.y)];
    } else if (currentSpritePosition.x > (levelSize.width - xOffset)) {
        [self setPosition:ccp((levelSize.width - xOffset), currentSpritePosition.y)];
    }
}



@end
