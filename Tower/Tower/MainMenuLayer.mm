//
//  MainMenuLayer.m
//  PlayBoal
//
//  Created by Nina Qiu on 7/23/14.
//  Copyright (c) 2014 WhaleKiss. All rights reserved.
//

#import "MainMenuLayer.h"
#import "World.h"
#import "GameState.h"


@interface MainMenuLayer()
-(void)displayMainMenu;
-(void)displaySceneSelection;
@end

@implementation MainMenuLayer



-(void)score {
     CCLOG(@"Show the Score screen");
    [[GameManager sharedGameManager] runSceneWithID:kScoreScene];
}


-(void)showOptions {
    CCLOG(@"Show the Options screen");
    [[GameManager sharedGameManager] runSceneWithID:kOptionsScene];
}



-(void)displayMainMenu {
    CGSize screenSize = [CCDirector sharedDirector].winSize;
    if (sceneSelectMenu != nil) {
        [sceneSelectMenu removeFromParentAndCleanup:YES];
    }
    // Main Menu
    CCMenuItemImage *playGameButton = [CCMenuItemImage
                                       itemFromNormalImage:@"startgame.png"
                                       selectedImage:@"startgame-pressed.png"
                                       disabledImage:nil
                                       target:self
                                       selector:@selector(displaySceneSelection)];
    
    CCMenuItemImage *scoreButton = [CCMenuItemImage
                                      itemFromNormalImage:@"score.png"
                                      selectedImage:@"score-pressed.png"
                                      disabledImage:nil
                                      target:self
                                      selector:@selector(score)];
    
    CCMenuItemImage *optionsButton = [CCMenuItemImage
                                      itemFromNormalImage:@"setting.png"
                                      selectedImage:@"setting.png"
                                      disabledImage:nil
                                      target:self
                                      selector:@selector(showOptions)];
    
    mainMenu = [CCMenu
                menuWithItems:playGameButton,scoreButton,optionsButton,nil];
    [mainMenu alignItemsVerticallyWithPadding:screenSize.height * 0.1f];
    [mainMenu setPosition:
     ccp(screenSize.width,
         screenSize.height / 2.0f)];
    id moveAction =
    [CCMoveTo actionWithDuration:1.2f
                        position:ccp(screenSize.width * 0.5f,
                                     screenSize.height/2.0f)];
    id moveEffect = [CCEaseIn actionWithAction:moveAction rate:1.0f];
    [mainMenu runAction:moveEffect];
    [self addChild:mainMenu z:0 tag:kMainMenuTagValue];
}

-(void)displaySceneSelection {
    [GameManager startGame];
}


-(id)init {
    self = [super init];
    if (self != nil) {
        CGSize screenSize = [CCDirector sharedDirector].winSize;
        
        CCSprite *background =
        [CCSprite spriteWithFile:@"background.png"];
        [background setPosition:ccp(screenSize.width/2,
                                    screenSize.height/2)];
        [self addChild:background];
        [self displayMainMenu];
        
//        CCSprite *squre =
//        [CCSprite spriteWithFile:@"squre2.png"];
//        [squre setPosition:ccp(screenSize.width * 0.35f,
//                                screenSize.height * 0.45f)];
//        [self addChild:squre];
//        
//        id rotateAction = [CCEaseElasticInOut actionWithAction:
//                           [CCRotateBy actionWithDuration:5.5f
//                                                    angle:360]];
//        
//        id scaleUp = [CCScaleTo actionWithDuration:2.0f scale:1.5f];
//        id scaleDown = [CCScaleTo actionWithDuration:2.0f scale:0.5f];
//        
//        [squre runAction:[CCRepeatForever actionWithAction:
//                           [CCSequence
//                            actions:scaleUp,scaleDown,nil]]];
//        
//        [squre runAction:
//        [CCRepeatForever actionWithAction:rotateAction]];
        
        [GameManager configMusic];
        CCLOG(@"加载main menu结束");
        
    }
    return self;
}
@end
