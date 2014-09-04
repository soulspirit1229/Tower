//
//  LevelCompleteSuccessLayer.m
//  Test
//
//  Created by Nina Qiu on 8/24/14.
//  Copyright (c) 2014 WhaleKiss. All rights reserved.
//

#import "LevelCompleteSuccessLayer.h"

#import "World.h"
#import "GameState.h"


@implementation LevelCompleteSuccessLayer

-(void) unlockScene {
    CCLOG(@"关卡还未解锁");
}


-(void) createLevelSprite:(NSArray*) images{
    int finishLevel = [GameState sharedInstance].completedLevel-100;
    CCLOG(@"finishe level is :%i",finishLevel);
    
    //finishelevel = 1 means open 2level for him.
    if (finishLevel>=0) {
        for (int i=0;i<9;i++) {
            CCLOG(@"int is:%i",i);
            CCSprite *levelSprite = nil;
            CCMenuItemSprite *menuSprite = nil;
            if (i<=finishLevel) {
                NSString *image = [images objectAtIndex:i];
                CCLOG(@"load the iamges is :%@",image);
                levelSprite = [CCSprite spriteWithSpriteFrameName:image];
                levelSprite.tag = i+1;
                menuSprite = [CCMenuItemSprite itemWithNormalSprite:levelSprite selectedSprite:nil target:self selector:@selector(runNextScene:)];
            }else {
                levelSprite = [CCSprite spriteWithSpriteFrameName:@"levellock.png"];
                levelSprite.tag = i+1;
                menuSprite = [CCMenuItemSprite itemWithNormalSprite:levelSprite selectedSprite:nil target:self selector:@selector(unlockScene)];
            }
            [levelSprites addObject:menuSprite];
        }
    }
}

-(id)init {
    
    if (self = [super init]) {
        CCSprite *background = [CCSprite spriteWithSpriteFrameName:@"success.png"];
        [background setPosition:ccp(screenSize.width/2, screenSize.height/2)];
        [self addChild:background z:0];
        
        levelSprites = [[NSMutableArray alloc]init];
        [self createLevelSprite:images];
        CCLOG(@"load the %i images into nsarray.",levelSprites.count);
        
        firstMainMenu = [CCMenu menuWithItems:levelSprites[0],levelSprites[1],levelSprites[2] ,nil];
        [firstMainMenu alignItemsHorizontallyWithPadding:screenSize.width * 0.08f];
        [firstMainMenu setPosition:ccp(screenSize.width/2.0f,3*screenSize.height / 4.0f)];
        
        secondMainMenu = [CCMenu menuWithItems:levelSprites[3],levelSprites[4],levelSprites[5] ,nil];
        [secondMainMenu alignItemsHorizontallyWithPadding:screenSize.width * 0.08f];
        [secondMainMenu setPosition:ccp(screenSize.width/2.0f,7*screenSize.height / 12.0f)];
        
        thirdMainMenu = [CCMenu menuWithItems:levelSprites[6],levelSprites[7],levelSprites[8] ,nil];
        [thirdMainMenu alignItemsHorizontallyWithPadding:screenSize.width * 0.08f];
        [thirdMainMenu setPosition:ccp(screenSize.width/2.0f,5*screenSize.height / 12.0f)];
        
        [self addChild:firstMainMenu];
        [self addChild:secondMainMenu];
        [self addChild:thirdMainMenu];
        
        CCSprite *returnToMainMenuSprite= [CCSprite spriteWithSpriteFrameName:@"levelselectbtn.png"];
        
        CCMenuItemSprite *mainMenuBtn = [CCMenuItemSprite itemWithNormalSprite:returnToMainMenuSprite selectedSprite:nil target:self selector:@selector(returnToMainMenu)];
        backMenu = [CCMenu
                    menuWithItems:mainMenuBtn,nil];
        [backMenu setPosition:ccp(screenSize.width/2.0f,3*screenSize.height / 12.0f)];
        [self addChild:backMenu];
        CCLOG(@"加载layer完毕");
        return self;
        
    }
    
    return self;
}



-(void)returnToMainMenu {
	[[GameManager sharedGameManager] runSceneWithID:kMainMenuScene];
}


-(void) runNextScene:(id)sender{
    
    CCMenuItemSprite *itemSprite = (CCMenuItemSprite*) sender;
    CCSprite* sprite = (CCSprite*)itemSprite.normalImage;
    int level = sprite.tag;
    if (level==1) {
        [World resetWorld];
        [[GameManager sharedGameManager] runSceneWithID:kGameLevel1];
        return;
        
    }
    
    if (level==2) {
        [World resetWorld];
        [[GameManager sharedGameManager] runSceneWithID:kGameLevel2];
        return;
        
    }
    
    if (level==3) {
        [World resetWorld];
        [[GameManager sharedGameManager] runSceneWithID:kGameLevel3];
        return;
        
    }
    
    
    // CCLOG([item.label.string stringByAppendingString:unlock]);
}


@end
