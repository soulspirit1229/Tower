//
//  LevelBase.h
//  Test
//
//  Created by Nina Qiu on 8/23/14.
//  Copyright (c) 2014 WhaleKiss. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Box2D.h"
#import "BlockConstant.h"
#import "Block.h"
#import "GameManager.h"



// 该类作为关卡的父类，承担了很多关卡的实现
// 1 在规定的时间完成所有物体的堆放
// 2 所有的物体不能超出边界
@interface LevelBase : CCLayer {
    int blocksNumber; //block,not include generated by user
    int groundBlockNumber;// ground block number,default is 1;
    int createBlockNumber;
    
    
    b2World *_world;
    SceneTypes sceneType;
    b2MouseJoint *_mouseJoint;
    
    
    b2Body *groundblockBody;
    CGSize winSize;
    CCSprite *groundblock;// ground block
    CCLabelTTF *timeLabel;
    int gameTime;
    NSMutableArray *_blocks;
    int blockFinishedNumber;//block has been moved.
    CCSpriteBatchNode* spritesBgNode;
}


+(CCScene *) scene:(SceneTypes) sceneType;

@end

