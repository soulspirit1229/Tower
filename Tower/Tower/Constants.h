//
//  Constants.h
//  PlayBoal
//
//  Created by Nina Qiu on 7/23/14.
//  Copyright (c) 2014 WhaleKiss. All rights reserved.
//

#ifndef PlayBoal_Constants_h
#define PlayBoal_Constants_h

//  Constants.h
// Constants used in SpaceViking

#define kVikingSpriteZValue 100
#define kVikingSpriteTagValue 0
#define kVikingIdleTimer 3.0f
#define kVikingFistDamage 10
#define kVikingMalletDamage 40
#define kRadarDishTagValue 10

#define kMainMenuTagValue 10
#define kSceneMenuTagValue 20

typedef enum {
    kNoSceneUninitialized=0,
    kMainMenuScene=1,
    kOptionsScene=2,
    kScoreScene=3,
    kIntroScene=4,
    kLevelCompleteScene=5,
    kGameLevel1=101,
    kGameLevel2=102,
    kGameLevel3=103,
    kGameLevel4=104,
    kGameLevel5=105,
    kGameLevel6=106,
    kGameLevel7=107,
    kGameLevel8=108,
    kGameLevel9=109,
    kFailureScene=500,
    kCutSceneForLevel2=201
} SceneTypes;


typedef enum {
    kCircle,
    kTriangle,
    kSqure
} BlockTypes;

// Debug Enemy States with Labels
// 0 for OFF, 1 for ON
#define ENEMY_STATE_DEBUG 0


#endif
