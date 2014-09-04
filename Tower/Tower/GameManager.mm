//
//  GameManager.m
//  PlayBoal
//
//  Created by Nina Qiu on 7/23/14.
//  Copyright (c) 2014 WhaleKiss. All rights reserved.
//

#import "GameManager.h"
#import "GameState.h"
#import "MainMenuScene.h"
#import "OptionsScene.h"
#import "ScoreScene.h"
#import "LevelCompleteSuccessScene.h"
#import "LevelBase.h"
#import "FailureScene.h"
#import "SimpleAudioEngine.h"
#import "World.h"

@implementation GameManager

static GameManager* _sharedGameManager = nil;

@synthesize isMusicON;
@synthesize isSoundEffectsON;
@synthesize hasPlayerDied;
@synthesize curLevel;
@synthesize lastLevel;

+(GameManager*)sharedGameManager {
    @synchronized([GameManager class])
    {
        if(!_sharedGameManager)
            [[self alloc] init];
        return _sharedGameManager;
    }
    return nil;
}

+(id)alloc
{
    @synchronized ([GameManager class])
    {
        NSAssert(_sharedGameManager == nil,
                 @"Attempted to allocated a second instance of the Game Manager singleton");
        _sharedGameManager = [super alloc];
        return _sharedGameManager;
    }
    return nil;
}

-(id)init {
    self = [super init];
    if (self != nil) {
        // Game Manager initialized
        CCLOG(@"Game Manager Singleton, init");
        isMusicON = YES;
        isSoundEffectsON = YES;
        hasPlayerDied = NO;
        currentScene = kNoSceneUninitialized;
    }
    return self;
}


+(SceneTypes) levelToSceneType:(int) level {
    SceneTypes scene =  kNoSceneUninitialized;
    switch (level) {
        case 101:
            scene  = kGameLevel1;
            break;
        case 102:
            scene  = kGameLevel2;
            break;
        case 103:
            scene  = kGameLevel3;
            break;
        case 104:
            scene  = kGameLevel4;
            break;
        case 105:
            scene  = kGameLevel5;
            break;
        case 106:
            scene  = kGameLevel6;
            break;
        case 107:
            scene  = kGameLevel7;
            break;
        case 108:
            scene  = kGameLevel8;
            break;
        case 109:
            scene  = kGameLevel9;
            break;
    }
    return scene;
}

//开始游戏，可以是接着你完成的关卡进行
+(void) startGame {
    [World resetWorld];
    int level = [GameState sharedInstance].completedLevel;
    CCLOG(@"你当前进行的关卡是：%i",level);
    SceneTypes levelSceneType = [GameManager levelToSceneType:level];
    if (levelSceneType != kNoSceneUninitialized) {
        [[GameManager sharedGameManager] runSceneWithID:levelSceneType];
    }else {
        [[GameManager sharedGameManager] runSceneWithID:kGameLevel1];
    }

}

// 播放背景音乐基于配置
+(void) configMusic {
    if ([GameManager sharedGameManager].isMusicON) {
        // Start up the background music
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"background-music-aac.caf"];
    }
    
    if (![GameManager sharedGameManager].isMusicON) {
         [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
    
    
    }
}

// 播放音乐特效基于配置
+(void) configMusicEffect {
    if ([GameManager sharedGameManager].isSoundEffectsON) {
        // Start up the background music
        [[SimpleAudioEngine sharedEngine] playEffect:@"pew-pew-lei.caf"];
    }
}


-(void)runSceneWithID:(SceneTypes)sceneID {
    
    SceneTypes oldScene = currentScene;
    currentScene = sceneID;
    
    id sceneToRun = nil;
    switch (sceneID) {
            
        case kMainMenuScene:
            sceneToRun = [MainMenuScene node];
            break;
            
        case kOptionsScene:
            sceneToRun = [OptionsScene node];
            break;
            
        case kScoreScene:
            sceneToRun = [ScoreScene node];
            break;
       
        case kLevelCompleteScene:
            sceneToRun = [LevelCompleteSuccessScene node];
            break;
            
        case kFailureScene:
            sceneToRun = [FailureScene node];
            break;
            
        case kGameLevel1:
            sceneToRun = [LevelBase scene:kGameLevel1];
            break;

        case kGameLevel2:
            sceneToRun = [LevelBase scene:kGameLevel2];
            break;
            
        case kGameLevel3:
           sceneToRun = [LevelBase scene:kGameLevel3];
            break;
        case kGameLevel4:
            sceneToRun = [LevelBase scene:kGameLevel4];
            break;
        case kGameLevel5:
            sceneToRun = [LevelBase scene:kGameLevel5];
            break;
        case kGameLevel6:
            sceneToRun = [LevelBase scene:kGameLevel6];
            break;
        case kGameLevel7:
            sceneToRun = [LevelBase scene:kGameLevel7];
            break;
        case kGameLevel8:
            sceneToRun = [LevelBase scene:kGameLevel8];
            break;
        case kGameLevel9:
            sceneToRun = [LevelBase scene:kGameLevel9];
            break;
        default:
            CCLOG(@"Unknown ID, cannot switch scenes");
            return;
            break;
    }
    if (sceneToRun == nil) {
        // Revert back, since no new scene was found
        currentScene = oldScene;
        return;
    }
    
    if ([[CCDirector sharedDirector] runningScene] == nil) {
        [[CCDirector sharedDirector] runWithScene:sceneToRun];
        
    } else {
        
        [[CCDirector sharedDirector] replaceScene:sceneToRun];
    }
}


@end
