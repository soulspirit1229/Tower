//
//  LevelCompleteSuccessLayer.h
//  Test
//
//  Created by Nina Qiu on 8/24/14.
//  Copyright (c) 2014 WhaleKiss. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GameManager.h"
#import "LevelCompleteLayer.h"

@interface LevelCompleteSuccessLayer : LevelCompleteLayer {
    
    CCMenu *firstMainMenu;
    CCMenu *secondMainMenu;
    CCMenu *thirdMainMenu;
    CCMenu *backMenu;
    NSMutableArray *levelSprites;
}

@end