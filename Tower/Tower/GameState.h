//
//  GameState.h
//  Test
//
//  Created by Nina Qiu on 8/11/14.
//  Copyright (c) 2014 WhaleKiss. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface GameState : NSObject <NSCoding> {
    int completedLevel;
//    BOOL completedLevel2;
//    BOOL completedLevel3;
//    BOOL completedLevel4;
//    BOOL completedLevel5;
//    int timesFell;
}

+ (GameState *) sharedInstance;
- (void)save;

@property (assign) int completedLevel;
//@property (assign) BOOL completedLevel2;
//@property (assign) BOOL completedLevel3;
//@property (assign) BOOL completedLevel4;
//@property (assign) BOOL completedLevel5;
//@property (assign) int timesFell;

@end

