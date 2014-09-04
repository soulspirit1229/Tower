//
//  LevelCompleteLayer.m
//  SpaceViking
//
//  Created by Rod on 10/7/10.
//  Copyright 2010 Prop Group LLC - www.prop-group.com. All rights reserved.
//

#import "LevelCompleteLayer.h"


@implementation LevelCompleteLayer

-(id)init {
    
    if (self = [super init]) {
        
        spritesBgNode = [CCSpriteBatchNode batchNodeWithFile:@"levelselect.pvr.ccz"];
        [self addChild:spritesBgNode z:101];
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"levelselect.plist"];
        
        images = [NSArray arrayWithObjects:@"level1icon.png",@"level2icon.png",@"level3icon.png",@"level4icon.png",@"level5icon.png",@"level6icon.png",@"level7icon.png",@"level8icon.png",@"level9icon.png",nil];
        screenSize= [CCDirector sharedDirector].winSize;
        return self;
    }
    return self;
}

- (void)dealloc {
    [super dealloc];
       images = nil;
}

@end
