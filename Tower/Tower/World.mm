//
//  World.m
//  PlayBoal
//
//  Created by Nina Qiu on 7/22/14.
//  Copyright (c) 2014 WhaleKiss. All rights reserved.
//

#import "World.h"

@implementation World

static b2World *_world = nil;
+(b2World*) sharedWorld {
    if (_world == nil) {
        b2Vec2 gravity = b2Vec2(0.0f, -3.0f);
        _world =new b2World(gravity);
        _world->SetAllowSleeping(true);
        
    }
    
   GLESDebugDraw *m_debugDraw = new GLESDebugDraw( PTM_RATIO );
	_world->SetDebugDraw(m_debugDraw);
	
	uint32 flags = 0;
	flags += b2Draw::e_shapeBit;
	//		flags += b2Draw::e_jointBit;
	//		flags += b2Draw::e_aabbBit;
	//		flags += b2Draw::e_pairBit;
	//		flags += b2Draw::e_centerOfMassBit;
	m_debugDraw->SetFlags(flags);
    return _world;
}

+(void) resetWorld {
    if (_world != nil)
    {
        _world = nil;
    }
}

@end
