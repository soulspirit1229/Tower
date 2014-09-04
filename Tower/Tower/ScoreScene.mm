//
//  CreditsScene.m
//  SpaceViking
//
//  Created by Rod on 9/18/10.
//  Copyright 2010 Prop Group LLC - www.prop-group.com. All rights reserved.
//

#import "ScoreScene.h"


@implementation ScoreScene
-(id)init {
	self = [super init];
	if (self != nil) {
		// Background Layer
		scoreLayer = [ScoreLayer node];
		[self addChild:scoreLayer];
	}
	return self;
}

@end
