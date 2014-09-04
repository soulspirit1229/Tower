//
//  LevelBase.m
//  Test
//
//  Created by Nina Qiu on 8/23/14.
//  Copyright (c) 2014 WhaleKiss. All rights reserved.
//

#import "LevelBase.h"
#import "Level1Scene.h"
#import "Level2Scene.h"
#import "Level3Scene.h"
#import "Level4Scene.h"
#import "Level5Scene.h"
#import "Level6Scene.h"
#import "Level7Scene.h"
#import "Level8Scene.h"
#import "Level9Scene.h"
#import "GameState.h"

@implementation LevelBase

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene:(SceneTypes) sceneType{
    CCScene *scene = [CCScene node];
    CCLayer *layer = nil;
    switch (sceneType) {
        case kGameLevel1:
            layer = [Level1Scene node];
            break;
            
        case kGameLevel2:
            layer = [Level2Scene node];
            break;
            //add more level here
        case kGameLevel3:
            layer = [Level3Scene node];
            break;

        case kGameLevel4:
            layer = [Level4Scene node];
            break;
        case kGameLevel5:
            layer = [Level5Scene node];
            break;
        case kGameLevel6:
            layer = [Level6Scene node];
            break;
        case kGameLevel7:
            layer = [Level7Scene node];
            break;
        case kGameLevel8:
            layer = [Level8Scene node];
            break;
        case kGameLevel9:
            layer = [Level9Scene node];
            break;

        default:
            CCLOG(@"Unknown ID, cannot switch scenes");
    }
    
    [scene addChild:layer];
    return scene;
}

//create floor
-(void) createFloor {
    
    CCSprite *floor = [CCSprite spriteWithSpriteFrameName:@"floor.png"];
    // 330-120 = 210, 330+120=450 floor的长度240，floor在屏幕中从210到450
    //floor 的高度在距离顶端相差一个sprite的高度
    floor.position=ccp(winSize.width-floor.contentSize.width/2, winSize.height-32-floor.contentSize.height/2);
    [self addChild:floor z:100];
    
    b2BodyDef baseBodyDef;
    baseBodyDef.position.Set((winSize.width-floor.contentSize.width/2)/PTM_RATIO, ( winSize.height-32-floor.contentSize.height/2)/PTM_RATIO);
    
    //1.b2World通过b2BodyDef创建b2Body，没有b2BodyDef，b2Body不知道是什么类型，放在世界什么位置。
    b2Body *baseBody =  _world->CreateBody(&baseBodyDef);
    
    b2PolygonShape baseBox;
    //b2Body通过b2FixtureDef创建b2Fixture，没有b2Fixture，b2Body不知道是什么形状，摩擦、弹性、密度都不知道。shpae提供了碰撞检测的外边框。
    baseBox.SetAsBox(floor.contentSize.width/2/PTM_RATIO, floor.contentSize.height/2/PTM_RATIO);
    baseBody->CreateFixture(&baseBox,0.0f);
}

// 由单独的关卡实现
-(void) createGround {
    
}
// 由单独的关卡实现
-(void) createBlocks {
    
}

//-(void) createBox2dGround:(CCSprite*) sprite {
//    b2BodyDef groundblockBodyDef;
//    groundblockBodyDef.position.Set(winSize.width/2/PTM_RATIO, sprite.contentSize.height/2/PTM_RATIO);
//    //1.b2World通过b2BodyDef创建b2Body，没有b2BodyDef，b2Body不知道是什么类型，放在世界什么位置。
//    b2Body *spriteBody =  _world->CreateBody(&groundblockBodyDef);
//    
//    b2PolygonShape groundblockBox;
//    
//    //b2Body通过b2FixtureDef创建b2Fixture，没有b2Fixture，b2Body不知道是什么形状，摩擦、弹性、密度都不知道。shpae提供了碰撞检测的外边框。
//    groundblockBox.SetAsBox(sprite.contentSize.width/2/PTM_RATIO, sprite.contentSize.height/2/PTM_RATIO);
//    spriteBody->CreateFixture(&groundblockBox,100.0f);
//}

-(id) init {
    if (self=[super init]) {
        //        sprintMoveIndex = 1;
        blockFinishedNumber=0;
        groundBlockNumber=1;
        createBlockNumber = 0;
        _blocks = [[NSMutableArray alloc]init];
        winSize = [CCDirector sharedDirector].winSize;
        if (_world != nil) {
            [World resetWorld];
        }
        
        _world = [World sharedWorld];
        
        spritesBgNode = [CCSpriteBatchNode batchNodeWithFile:@"sprite.pvr.ccz"];
        [self addChild:spritesBgNode z:101];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"sprite.plist"];
        
        CCSpriteBatchNode *levelSelectBgNode = [CCSpriteBatchNode batchNodeWithFile:@"levelselect.pvr.ccz"];
        [self addChild:levelSelectBgNode z:101];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"levelselect.plist"];
        

        
        [self createFloor];
        [self createGround];
        [self createBlocks];
        // self.isTouchEnabled=YES;
        [self schedule:@selector(tick:)];
        
        
        [GameManager configMusic];
        [CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_Default];
        
        [self registerWithTouchDispatcher];
        
        gameTime = 60;
        timeLabel = [CCLabelTTF labelWithString:@"60" fontName:@"Helvetica-Bold" fontSize:32];
		
        [timeLabel setPosition:ccp(16.0f , winSize.height-32.0f)];
        [timeLabel setColor:ccWHITE];
        [self addChild:timeLabel z:105];
		
		[self updateClockDisplay];
		[self schedule:@selector(onTick:) interval:1];
        //一分钟未完成游戏，失败
        [self scheduleOnce:@selector(gameOver) delay:60];
      

    }
    
    return self;
}

- (void) onTick:(ccTime)dt
{
	[self updateClockDisplay];
}

- (void) updateClockDisplay
{
    gameTime--;
    NSString *ValueString = [NSString stringWithFormat:@"%d", gameTime];
    [timeLabel setString:ValueString];
}

-(void) gameOver {
    [GameManager sharedGameManager].curLevel = sceneType;
    [GameManager sharedGameManager].hasPlayerDied = YES;
    [[GameManager sharedGameManager] runSceneWithID:kFailureScene];
}

// Add these new methods
-(void) registerWithTouchDispatcher
{
    [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0
                                              swallowsTouches:YES];
}

-(id) reset {
    [_blocks release];
    _blocks = nil;
    _world=NULL;
    _mouseJoint = NULL;
    return self;
}

- (void)tick:(ccTime) dt {
    
    _world->Step(dt, 10, 10);
    for(b2Body *b = _world->GetBodyList(); b; b=b->GetNext()) {
        if (b->GetUserData() != NULL) {
            CCSprite *ballData = (CCSprite *)b->GetUserData();
            ballData.position = ccp(b->GetPosition().x * PTM_RATIO,
                                    b->GetPosition().y * PTM_RATIO);
            ballData.rotation =-1* CC_RADIANS_TO_DEGREES(b->GetAngle());
            
            if (ballData.position.y<0) {
                //[self release];
                CCLOG(@"当前已经有物体飞出舞台");
                [self gameOver];
            }
        }
    }
    
    //blockFinishedNumber在用户自己创建block以及关卡设计的block的总和；
    if (blockFinishedNumber==blocksNumber) {
        int count = 0;
        for(b2Body *b = _world->GetBodyList(); b; b=b->GetNext()) {
            if (!b->IsAwake()) {
                count++;
            }
        }
        
        //当所有的物体保持sleep的时候，这事可以判定当前用户已经成功
        if (count==(groundBlockNumber+blockFinishedNumber)) {
            CCLOG(@"**************当前静止不懂的物体为 :%i",count);
            [self performSelector:@selector(saveAndRunNextScene) withObject:self afterDelay:3];
            //延迟三秒之后进行下一关
            [self unschedule:@selector(tick:)];
            
        }
        
    }
}

// 当当前完成当关卡数大于你以前当记录当时候，保存当前的关卡层级以及展示关卡结束的画面
-(void) saveAndRunNextScene {
    [GameManager sharedGameManager].curLevel = sceneType;
    [GameManager sharedGameManager].hasPlayerDied = NO;
    
    if (([GameState sharedInstance].completedLevel ==0) || ([GameState sharedInstance].completedLevel < sceneType)) {
        
        [GameState sharedInstance].completedLevel = sceneType;
        [[GameState sharedInstance] save];
    }
    [[GameManager sharedGameManager] runSceneWithID:kLevelCompleteScene];
}

//基于Sprite创建Block
-(void)spriteMoveFinished:(id)sender {
    CCSprite *sprite = (CCSprite *)sender;
    Block *_block = [[[Block alloc] init] initWithSprite:sprite];
    [_blocks addObject:_block];
    blockFinishedNumber++;
}


-(void) dealloc {
    [super dealloc];
    _world = NULL;
    groundblockBody = NULL;
    _mouseJoint = NULL;
    groundblockBody = NULL;
    [groundblock release];
    groundblock = nil;
}



-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    CGPoint location = [self convertTouchToNodeSpace:touch];
    b2Vec2 locationWorld = b2Vec2(location.x/PTM_RATIO, location.y/PTM_RATIO);
   
    for (Block *blockInScene in _blocks) {
        CCSprite *block = blockInScene.sprite;
        // 如何判断一个点是否在一个三角形之内
        
       //        CGRect rect = CGRectMake(block.position.x-(block.contentSize.width/2), block.position.y-(block.contentSize.height/2), block.contentSize.width, block.contentSize.height);
        CGRect blockRect = [block boundingBox];
        BOOL contains = CGRectContainsPoint(blockRect,  location);
        CCLOG(@"the block rect is original x,original,size x, size y:%f,%f,%f,%f",blockRect.origin.x,blockRect.origin.y,blockRect.size.width,blockRect.size.height);
        if (block.tag>=200 && contains) {
            if (CGRectContainsPoint(blockRect, location)) {
                b2MouseJointDef md;
                md.bodyA = groundblockBody;
                md.bodyB = blockInScene.blockBody;
                md.target = locationWorld;
                md.collideConnected =true;
                md.maxForce =10.0f* blockInScene.blockBody->GetMass();
                
                _mouseJoint = (b2MouseJoint *)_world->CreateJoint(&md);
                blockInScene.blockBody->SetAwake(false);
                break;
            }
        }
        // this is for squre and circle
        else {
            if (contains && blockInScene.blockFixture->TestPoint(locationWorld)) {
                b2MouseJointDef md;
                md.bodyA = groundblockBody;
                md.bodyB = blockInScene.blockBody;
                md.target = locationWorld;
                md.collideConnected =true;
                md.maxForce =10.0f* blockInScene.blockBody->GetMass();
                
                _mouseJoint = (b2MouseJoint *)_world->CreateJoint(&md);
                blockInScene.blockBody->SetAwake(false);
                break;
                
            }

        }
        
//        b2AABB *aabb = new b2AABB();
//        aabb->lowerBound.Set(location.x - 0.001, location.y  - 0.001);
//        aabb->upperBound.Set(location.x  + 0.001, location.y  + 0.001);
       
        
//        b2Shape *shape = blockInScene.blockFixture->GetShape();
//        if (shape->TestPoint(blockInScene.blockBody->GetTransform(), locationWorld)) {
//             b2MouseJointDef md;
//            md.bodyA = groundblockBody;
//             md.bodyB = blockInScene.blockBody;
//            md.target = locationWorld;
//            //md.collideConnected =true;
//            md.maxForce =10.0f* blockInScene.blockBody->GetMass();
//            _mouseJoint = (b2MouseJoint *)_world->CreateJoint(&md);
//           // blockInScene.blockBody->SetAwake(false);
//             break;
//        }
    }
    
    
    
    if (_mouseJoint != NULL)  {
         CCLOG(@"开始移动物体");
        return TRUE;}
   
    return FALSE;
}

-(void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event {
    CGPoint location = [self convertTouchToNodeSpace:touch];
    
    
    CCLOG(@"移动物体中");
    if (_mouseJoint == NULL) return;
    b2Vec2 locationWorld = b2Vec2(location.x/PTM_RATIO, location.y/PTM_RATIO);
    
    _mouseJoint->SetTarget(locationWorld);
}

//-(void)ccTouchesCancelled:(UITouch *)touch withEvent:(UIEvent *)event {
//    CCLOG(@"Start to draw and ccTouchesCancelled rect");
//
//    if (_mouseJoint) {
//        _world->DestroyJoint(_mouseJoint);
//        _mouseJoint = NULL;
//    }
//}

-(void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
    
    CGPoint point = [self convertTouchToNodeSpace:touch];
    
    if (_mouseJoint) {
        _world->DestroyJoint(_mouseJoint);
        _mouseJoint = NULL;
    }
    
    
    
}


-(void) draw
{
	//
	// IMPORTANT:
	// This is only for debug purposes
	// It is recommend to disable it
	//
	[super draw];
	
	ccGLEnableVertexAttribs( kCCVertexAttribFlag_Position );
	
	kmGLPushMatrix();
	
	_world->DrawDebugData();
	
	kmGLPopMatrix();
}


@end
