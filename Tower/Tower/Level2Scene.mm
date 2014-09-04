//
//  Level2Scene.m
//  Test
//
//  Created by Nina Qiu on 8/7/14.
//  Copyright (c) 2014 WhaleKiss. All rights reserved.
//

#import "Level2Scene.h"

@implementation Level2Scene
-(id) init {
    [super init];
    CCSprite *background =
    [CCSprite spriteWithFile:@"bluelevelscene.png"];
    [background setPosition:ccp(winSize.width/2,
                                winSize.height/2)];
    [self addChild:background z:0];
    
    sceneType = kGameLevel2;
    return self;
    
}


-(void) createGround {
    groundblock = [CCSprite spriteWithSpriteFrameName:@"floor.png"];
    groundblock.position=ccp(winSize.width/2, groundblock.contentSize.height/2);
    [self addChild:groundblock z:100];
    
    b2BodyDef groundblockBodyDef;
    groundblockBodyDef.position.Set(winSize.width/2/PTM_RATIO, groundblock.contentSize.height/2/PTM_RATIO);
    //1.b2World通过b2BodyDef创建b2Body，没有b2BodyDef，b2Body不知道是什么类型，放在世界什么位置。
    groundblockBody=  _world->CreateBody(&groundblockBodyDef);
    
    b2PolygonShape groundblockBox;
    
    //b2Body通过b2FixtureDef创建b2Fixture，没有b2Fixture，b2Body不知道是什么形状，摩擦、弹性、密度都不知道。shpae提供了碰撞检测的外边框。
    groundblockBox.SetAsBox(groundblock.contentSize.width/2/PTM_RATIO, groundblock.contentSize.height/2/PTM_RATIO);
    groundblockBody->CreateFixture(&groundblockBox,100.0f);
    
}



-(void) createBlocks {
    NSArray *images = [NSArray arrayWithObjects:@"013.png", @"005.png", @"006.png", @"007.png", @"008.png",@"101.png", nil];
    CCLOG(@"blocks number in this level is:%i",images.count);
    blocksNumber = images.count;
    
    for(int i =0; i < images.count; ++i) {
        NSString *image = [images objectAtIndex:i];
        float offsetFraction = ((float)(i+1))/(images.count+1);
        
        CCSprite *sprite = [CCSprite spriteWithSpriteFrameName:image];
        CGPoint spriteOffset = ccp(winSize.width*offsetFraction*(images.count), winSize.height-32+sprite.contentSize.height/2);
        sprite.position = spriteOffset;
        sprite.tag = image.intValue;
        [spritesBgNode addChild:sprite];
        
        
        // Create the actions
        id actionMove = [CCMoveTo actionWithDuration:5*i position:ccp(winSize.width/2-sprite.contentSize.width/2, winSize.height-32+sprite.contentSize.height/2)];
        //id actionDrop = [CCMoveTo actionWithDuration:5 position:ccp(sprite.contentSize.width/2, 0)];
        id actionMoveDone = [CCCallFuncN actionWithTarget:self selector:@selector(spriteMoveFinished:)];
        [sprite runAction:[CCSequence actions:actionMove,actionMoveDone, nil]];
    }
    
}



@end
