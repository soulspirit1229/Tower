//
//  World.h
//  PlayBoal
//
//  Created by Nina Qiu on 7/22/14.
//  Copyright (c) 2014 WhaleKiss. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Box2D.h"

#import <GameKit/GameKit.h>
#import "GLES-Render.h"
#import "BlockConstant.h"


@interface World : CCNode {

}

+(b2World*) sharedWorld;
+(void) resetWorld;

@end
