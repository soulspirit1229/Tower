//
//  FailureLayer.m
//  Test
//
//  Created by Nina Qiu on 8/6/14.
//  Copyright (c) 2014 WhaleKiss. All rights reserved.
//

#import "FailureLayer.h"
#import "World.h"

@implementation FailureLayer

-(id) init
{
    if(self=[super init]) {
        
        CCSprite *background = [CCSprite spriteWithSpriteFrameName:@"failure.png"];
        [background setPosition:ccp(screenSize.width/2, screenSize.height/2)];
        [self addChild:background z:0];

        
        
        CGSize winSize = [[CCDirector sharedDirector] winSize];

        CCLabelTTF *failureText = [CCLabelTTF labelWithString:@"失败乃兵家常事，大侠请重新再来" fontName:@"Arial" fontSize:16];
        failureText.color = ccc3(0,0,0);
        CCMenuItemLabel *failureLabel = [CCMenuItemLabel itemWithLabel:failureText target:self selector:nil];

        
//        CCMenuItemImage *playGameButton = [CCMenuItemImage itemFromNormalImage:@"restartgame.png"
//                                           selectedImage:@"restartgame.png"
//                                           disabledImage:nil
//                                           target:self
//                                           selector:@selector(displaySceneSelection)];
        
//        CCMenuItemImage *mainMenuButton = [CCMenuItemImage
//                                          itemFromNormalImage:@"backtomenu.png"
//                                          selectedImage:@"backtomenu.png"
//                                          disabledImage:nil
//                                          target:self
//                                          selector:@selector(backToMenu)];

        
        CCSprite *reStartGameSprite= [CCSprite spriteWithSpriteFrameName:@"restartgame.png"];
        
        CCMenuItemSprite *rStartGameBtn = [CCMenuItemSprite itemWithNormalSprite:reStartGameSprite selectedSprite:nil target:self selector:@selector(displaySceneSelection)];
        
        CCSprite *returnToMainMenuSprite= [CCSprite spriteWithSpriteFrameName:@"levelselectbtn.png"];
        
        CCMenuItemSprite *backMenuBtn = [CCMenuItemSprite itemWithNormalSprite:returnToMainMenuSprite selectedSprite:nil target:self selector:@selector(returnToMainMenu)];
        
        
        
        CCMenu *mainMenu = [CCMenu
                    menuWithItems:failureLabel,rStartGameBtn,backMenuBtn,nil];
        [mainMenu alignItemsVerticallyWithPadding:winSize.height * 0.15f];
        [mainMenu setPosition:
         ccp(winSize.width/2.0f,
             winSize.height / 2.0f)];
        
        [self addChild:mainMenu z:100];
        CCLOG(@"Failure layer is setup");

    
    }
    return self;
}


-(void) returnToMainMenu {
     [[GameManager sharedGameManager] runSceneWithID:kMainMenuScene];
}

-(void)displaySceneSelection {
    [GameManager startGame];
}

- (void)dealloc {
      [super dealloc];
}


@end
