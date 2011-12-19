//
//  ContactFiltering.m
//  2Swap
//
//  Created by Wairung Tiranalinvit on 12/19/54 BE.
//  Copyright (c) 2554 __MyCompanyName__. All rights reserved.
//

#import "ContactFiltering.h"
#import "Constants.h"

ContactFiltering::ContactFiltering() {
}

ContactFiltering::~ContactFiltering() {
}


bool ContactFiltering::ShouldCollide(b2Fixture* fixtureA, b2Fixture* fixtureB)
{
    const b2Filter& filterA = fixtureA->GetFilterData();
    const b2Filter& filterB = fixtureB->GetFilterData();
    if (((filterA.groupIndex == kGIndexFilterPlayerBlackTagValue && filterB.groupIndex == kGIndexFilterStaticPlatformerTagValue) ||
        (filterA.groupIndex == kGIndexFilterPlayerRedTagValue && filterB.groupIndex == kGIndexFilterStaticPlatformerTagValue)) ||
        ((filterB.groupIndex == kGIndexFilterPlayerBlackTagValue && filterA.groupIndex == kGIndexFilterStaticPlatformerTagValue) ||
         (filterB.groupIndex == kGIndexFilterPlayerRedTagValue && filterA.groupIndex == kGIndexFilterStaticPlatformerTagValue))) 
    {
        return true;
    } 
    else if((filterA.groupIndex == kGIndexFilterPlayerBlackTagValue && filterB.groupIndex == kGIndexFilterBlackPlatformerTagValue) ||
            (filterB.groupIndex == kGIndexFilterPlayerBlackTagValue && filterA.groupIndex == kGIndexFilterBlackPlatformerTagValue))
    {
        return true;
    }
    else if((filterA.groupIndex == kGIndexFilterPlayerRedTagValue && filterB.groupIndex == kGIndexFilterRedPlatformerTagValue) ||
            (filterB.groupIndex == kGIndexFilterPlayerRedTagValue && filterA.groupIndex == kGIndexFilterRedPlatformerTagValue))
    {
        return true;
    }
    return false;
}