//  GameControlLayer.m
//  SpaceViking
//
#import "GameControlLayer.h"

@implementation GameControlLayer
@synthesize leftJoystick;
@synthesize jumpButton;
@synthesize attackButton;

-(void)initJoystickAndButtons {
    CGSize screenSize = [CCDirector sharedDirector].winSize;       
    CGRect joystickBaseDimensions = CGRectMake(0, 0, 100.0f, 100.0f);
    CGRect jumpButtonDimensions = CGRectMake(0, 0, 57.0f, 55.0f);
    CGRect attackButtonDimensions = CGRectMake(0, 0, 56.0f, 56.0f);
    CGPoint joystickBasePosition;
    CGPoint jumpButtonPosition;
    CGPoint attackButtonPosition;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        // The device is an iPad running iPhone 3.2 or later.
        CCLOG(@"Positioning Joystick and Buttons for iPad");
        joystickBasePosition = ccp(screenSize.width*0.0625f,
                                   screenSize.height*0.052f);
        
        jumpButtonPosition = ccp(screenSize.width*0.946f,
                                 screenSize.height*0.052f);
        
        attackButtonPosition = ccp(screenSize.width*0.947f,
                                   screenSize.height*0.169f);
    } else {
        // The device is an iPhone or iPod touch.
        CCLOG(@"Positioning Joystick and Buttons for iPhone");
        
        joystickBasePosition = ccp(screenSize.width*0.12f,
                                   screenSize.height*0.18f);
        
        jumpButtonPosition = ccp(screenSize.width*0.93f,
                                 screenSize.height*0.13f);
        
        attackButtonPosition = ccp(screenSize.width*0.93f,
                                   screenSize.height*0.35f);
    }
    
    SneakyJoystickSkinnedBase *joystickBase =
    [[[SneakyJoystickSkinnedBase alloc] init] autorelease];        
    joystickBase.position = joystickBasePosition;                  
    joystickBase.backgroundSprite = 
    [CCSprite spriteWithFile:@"dpadDown.png"];                    
    joystickBase.thumbSprite = 
    [CCSprite spriteWithFile:@"joystickDown.png"];                 
    joystickBase.joystick = [[SneakyJoystick alloc]
                             initWithRect:joystickBaseDimensions]; 
    leftJoystick = [joystickBase.joystick retain];                
    [self addChild:joystickBase];                                 
    
    SneakyButtonSkinnedBase *jumpButtonBase =
    [[[SneakyButtonSkinnedBase alloc] init] autorelease];         
    jumpButtonBase.position = jumpButtonPosition;                 
    jumpButtonBase.defaultSprite = 
    [CCSprite spriteWithFile:@"jumpUp.png"];                      
    jumpButtonBase.activatedSprite = 
    [CCSprite spriteWithFile:@"jumpDown.png"];                    
    jumpButtonBase.pressSprite = 
    [CCSprite spriteWithFile:@"jumpDown.png"];                    
    jumpButtonBase.button = [[SneakyButton alloc] 
                             initWithRect:jumpButtonDimensions];  
    jumpButton = [jumpButtonBase.button retain];                  
    jumpButton.isToggleable = NO;                                 
    [self addChild:jumpButtonBase];                               
    
    SneakyButtonSkinnedBase *attackButtonBase = [[[SneakyButtonSkinnedBase alloc] init] autorelease];             
    attackButtonBase.position = attackButtonPosition;             
    attackButtonBase.defaultSprite = [CCSprite spriteWithFile:@"swapUp.png"];                                    
    attackButtonBase.activatedSprite = [CCSprite spriteWithFile:@"swapDown.png"];                                  
    attackButtonBase.pressSprite = [CCSprite spriteWithFile:@"swapDown.png"];                                  
    attackButtonBase.button = [[SneakyButton alloc] initWithRect:attackButtonDimensions];                             
    attackButton = [attackButtonBase.button retain];              
    attackButton.isToggleable = NO;                               
    [self addChild:attackButtonBase];                             
}

-(id)init {
    self = [super init];
    if (self != nil) {
        // enable touches
        self.isTouchEnabled = YES; 
        [self initJoystickAndButtons]; // 4
        CCLOG(@"GameControlLayer initialized");
    }
    return self; 
}
@end
