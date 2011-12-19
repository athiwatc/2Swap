//
//  ContactFiltering.h
//  2Swap
//
//  Created by Wairung Tiranalinvit on 12/19/54 BE.
//  Copyright (c) 2554 __MyCompanyName__. All rights reserved.
//

#import <Box2D.h>

class ContactFiltering : public b2ContactFilter {
public:
	ContactFiltering();
	~ContactFiltering();
    
	virtual bool ShouldCollide(b2Fixture* fixtureA, b2Fixture* fixtureB);
};