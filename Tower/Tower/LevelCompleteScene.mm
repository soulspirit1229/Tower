//
//  LevelCompleteScene.m
//  SpaceViking
//
//  Created by Rod on 10/7/10.
//  Copyright 2010 Prop Group LLC - www.prop-group.com. All rights reserved.
//

#import "LevelCompleteSuccessScene.h"
#import "LevelCompleteSuccessLayer.h"

@implementation LevelCompleteSuccessScene
-(id)init {
	self = [super init];
	if (self != nil) {
		LevelCompleteSuccessLayer *myLayer = [LevelCompleteSuccessLayer node];
		[self addChild:myLayer];
	}
	return self;
}
@end
