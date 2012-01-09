//
//  ContactListener.m
//  Scroller
//
//  Created by min on 1/16/11.
//  Copyright 2011 Min Kwon. All rights reserved.
//

#import "ContactListener.h"
#import "CommonProtocols.h"
#import "GameObject.h"

#define IS_BLACK_PLAYER(x, y)         (x.gameObjectType == kGameObjectPlayerBlack || y.gameObjectType == kGameObjectPlayerBlack)
#define IS_RED_PLAYER(x, y)         (x.gameObjectType == kGameObjectPlayerRed || y.gameObjectType == kGameObjectPlayerRed)
#define IS_STATIC_PLATFORM(x, y)       (x.gameObjectType == kGameObjectStaticPlatform || y.gameObjectType == kGameObjectStaticPlatform)
#define IS_RED_PLATFORM(x, y)       (x.gameObjectType == kGameObjectRedPlatform || y.gameObjectType == kGameObjectRedPlatform)
#define IS_BLACK_PLATFORM(x, y)       (x.gameObjectType == kGameObjectBlackPlatform || y.gameObjectType == kGameObjectBlackPlatform)
#define IS_GOAL_OBJECT(x, y)        (x.gameObjectType == kGameObjectGoal || y.gameObjectType == kGameObjectGoal)

ContactListener::ContactListener() {
    isJumping = false;
    isGoal = false;
}

ContactListener::~ContactListener() {
}

void ContactListener::BeginContact(b2Contact *contact) {
	GameObject *o1 = (GameObject*)contact->GetFixtureA()->GetBody()->GetUserData();
	GameObject *o2 = (GameObject*)contact->GetFixtureB()->GetBody()->GetUserData();
	
	if (IS_STATIC_PLATFORM(o1, o2) && (IS_BLACK_PLAYER(o1, o2) || IS_RED_PLAYER(o1, o2)) ) {
        CCLOG(@"-----> Player made contact with static platform!"); 
        isJumping = false;
    } else if (IS_RED_PLATFORM(o1, o2) && (IS_BLACK_PLAYER(o1, o2) || IS_RED_PLAYER(o1, o2)) ) {
        CCLOG(@"-----> Player made contact with red platform!");
        isJumping = false;
        
    } else if (IS_BLACK_PLATFORM(o1, o2) && (IS_BLACK_PLAYER(o1, o2) || IS_RED_PLAYER(o1, o2)) ) {
        CCLOG(@"-----> Player made contact with black platform!");
        isJumping = false;
    }
    
    if (IS_GOAL_OBJECT(o1, o2) && (IS_BLACK_PLAYER(o1, o2) || IS_RED_PLAYER(o1, o2))) {
        isGoal = true;
        isJumping = false;
    }
    //isJumping ? CCLOG(@"isJumping = true") : CCLOG(@"isJumping = false");
}

void ContactListener::EndContact(b2Contact *contact) {
	GameObject *o1 = (GameObject*)contact->GetFixtureA()->GetBody()->GetUserData();
	GameObject *o2 = (GameObject*)contact->GetFixtureB()->GetBody()->GetUserData();
    
    if (IS_STATIC_PLATFORM(o1, o2) && (IS_BLACK_PLAYER(o1, o2) || IS_RED_PLAYER(o1, o2)) ) {
        CCLOG(@"-----> Player made contact with static platform!");
        isJumping = true;
    } else if (IS_RED_PLATFORM(o1, o2) && (IS_BLACK_PLAYER(o1, o2) || IS_RED_PLAYER(o1, o2)) ) {
        CCLOG(@"-----> Player made contact with red platform!");
        isJumping = true;
        
    } else if (IS_BLACK_PLATFORM(o1, o2) && (IS_BLACK_PLAYER(o1, o2) || IS_RED_PLAYER(o1, o2)) ) {
        CCLOG(@"-----> Player made contact with black platform!");
        isJumping = true;
    }
    
    if (IS_GOAL_OBJECT(o1, o2) && (IS_BLACK_PLAYER(o1, o2) || IS_RED_PLAYER(o1, o2))) {
        isGoal = true;
        isJumping = true;
    }
    //isJumping ? CCLOG(@"isJumping = true") : CCLOG(@"isJumping = false");
}

void ContactListener::PreSolve(b2Contact *contact, const b2Manifold *oldManifold) {
}

void ContactListener::PostSolve(b2Contact *contact, const b2ContactImpulse *impulse) {
}
