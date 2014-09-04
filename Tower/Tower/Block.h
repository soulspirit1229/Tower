//
//  Block.h
//  PlayBoal
//
//  Created by Nina Qiu on 7/16/14.
//  Copyright (c) 2014 WhaleKiss. All rights reserved.
//

#import "cocos2d.h"
#import "Box2D.h"
#import "BlockConstant.h"
#import "World.h"

@interface Block : CCNode {
    CCSprite *_sprite;
    b2Body *_blockBody;
    b2Fixture *_blockFixture;
    BOOL isDynamic;
    
}
@property (readwrite ) CCSprite *sprite ;
@property (readwrite ) BOOL isDynamic ;
@property (readwrite ) b2Body *blockBody ;
@property (readwrite ) b2Fixture *blockFixture ;

-(id) initWithSprite:(CCSprite*) _sprite;


@end
