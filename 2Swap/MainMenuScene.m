//
//  MainMenuScene.m
//  2Swap
//
//  Created by Wairung Tiranalinvit on 7/11/11.
//  Copyright 2011 Kasetsart University. All rights reserved.
//

#import "MainMenuScene.h"
#import "GameScene.h"
#import "StoryModeScene.h"

@interface MainMenuScene (PrivateMethods)
-(void) createMenu:(ccTime)delta;
-(void) storyModeTouched:(id)sender;
-(void) challengeModeTouched:(id)sender;
-(void) hiScoreModeTouched:(id)sender;
@end

@implementation MainMenuScene

+ (id) scene
{
    CCScene* scene = [CCScene node];
    CCLayer* layer = [MainMenuScene node];
    [scene addChild:layer];
    return scene;
}

- (id) init
{
    if ((self = [super init]))
    {
        CCLOG(@"%@: %@", NSStringFromSelector(_cmd), self);
		
		self.isTouchEnabled = YES;
        [self schedule:@selector(createMenu:) interval:1];
    }
    return self;
}

- (void) createMenu:(ccTime)delta
{
    [self unschedule:_cmd];
    CCSprite* logo = [CCSprite spriteWithFile:@"2swap_logo_low.png"];
    CCSprite* story_img_butt = [CCSprite spriteWithFile:@"Story_mode_but.png"];
    CCSprite* story_img_butt_sel = [CCSprite spriteWithFile:@"Story_mode_but.png"];
    story_img_butt_sel.color = ccYELLOW;
    CCSprite* challenge_img_butt = [CCSprite spriteWithFile:@"Challenge_mode_but.png"];
    CCSprite* challenge_img_butt_sel = [CCSprite spriteWithFile:@"Challenge_mode_but.png"];
    challenge_img_butt_sel.color = ccRED;
    CCSprite* hiscore_img_butt = [CCSprite spriteWithFile:@"Hiscore_but.png"];
    CCSprite* hiscore_img_butt_sel = [CCSprite spriteWithFile:@"Hiscore_but.png"];
    hiscore_img_butt_sel.color = ccGREEN;
    CCMenuItemSprite* story_mode_butt = [CCMenuItemSprite itemFromNormalSprite:story_img_butt selectedSprite:story_img_butt_sel target:self selector:@selector(storyModeTouched:)];
    CCMenuItemSprite* challenge_mode_butt = [CCMenuItemSprite itemFromNormalSprite:challenge_img_butt selectedSprite:challenge_img_butt_sel target:self selector:@selector(challengeModeTouched:)];
    CCMenuItemSprite* hiscore_mode_butt = [CCMenuItemSprite itemFromNormalSprite:hiscore_img_butt selectedSprite:hiscore_img_butt_sel target:self selector:@selector(hiScoreModeTouched:)];
    CGSize size = [[CCDirector sharedDirector] winSize];
    CCMenu* menu = [CCMenu menuWithItems:story_mode_butt,challenge_mode_butt,hiscore_mode_butt, nil];
    [menu alignItemsHorizontallyWithPadding:10];
    menu.position = CGPointMake(size.width / 2, -2*size.height/8);
    logo.position = CGPointMake(size.width / 2, 6*size.height/8);
    [self addChild:menu];
    [self addChild:logo];
    
    CCMoveTo* move_menu = [CCMoveTo actionWithDuration:2 position:CGPointMake(size.width/2, 2*size.height/8)];
    CCEaseElasticOut* menu_action = [CCEaseElasticOut actionWithAction:move_menu period:0.8f];
    CCFadeIn* fade_logo = [CCFadeIn actionWithDuration:2];
    [logo runAction:fade_logo];
    [menu runAction:menu_action];
}


- (void) storyModeTouched:(id)sender
{
    CCLOG(@"Story_Mode Button touched : %@",sender);
    [[CCDirector sharedDirector] replaceScene:[StoryModeScene scene]];
}

- (void) challengeModeTouched:(id)sender
{
    CCLOG(@"Challenge_Mode Button touched : %@",sender);
    [[CCDirector sharedDirector] replaceScene:[GameScene scene]];
}

- (void) hiScoreModeTouched:(id)sender
{
    CCLOG(@"Hi-Score_Mode Button touched : %@",sender);
}

- (void) dealloc
{
    [super dealloc];
}

@end
