//
//  FailureScene.m
//  Test
//
//  Created by Nina Qiu on 8/6/14.
//  Copyright (c) 2014 WhaleKiss. All rights reserved.
//

#import "FailureScene.h"
#import "FailureLayer.h"


@implementation FailureScene

-(id)init {
	self = [super init];
	if (self != nil) {
		FailureLayer *myLayer = [FailureLayer node];
		[self addChild:myLayer];
		
	}
	return self;
}

@end
