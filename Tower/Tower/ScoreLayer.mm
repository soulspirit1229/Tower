//
//  CreditsLayer.m
//  SpaceViking
//
//  Created by Rod on 9/18/10.
//  Copyright 2010 Prop Group LLC - www.prop-group.com. All rights reserved.
//

#import "ScoreLayer.h"
#import "GameState.h"


@implementation ScoreLayer



-(id)init {
	self = [super init];
	if (self != nil) {
		CGSize screenSize = [CCDirector sharedDirector].winSize; 
		CCSprite *background = [CCSprite spriteWithFile:@"settingbackground.png"];
		[background setPosition:ccp(screenSize.width/2, screenSize.height/2)];
		[self addChild:background];
        
        int level = [GameState sharedInstance].completedLevel;
      //  level = 10;
//        NSString *levelString;
//        
//        if (level==101) {
//            levelString = @"第一关";
//        }else if (level ==102) {
//            levelString = @"第二关";
//        }else if (level ==103) {
//            levelString = @"第三关";
//        }
//        
//        
//        if (level>=101 && level<=105) {
//            CCLabelTTF *levelLabelText = [CCLabelTTF labelWithString:@"你现在通关：" fontName:@"Arial" fontSize:32];
//            levelLabelText.color = ccc3(0,0,0);
//            [levelLabelText setPosition:ccp(1*screenSize.width/5,screenSize.height*5/6)];
//            
//            CCLabelTTF *levelText = [CCLabelTTF labelWithString:levelString fontName:@"Arial" fontSize:32];
//            levelLabelText.color = ccc3(0,0,0);
//            [levelText setPosition:ccp(1*screenSize.width/5,screenSize.height*4/6)];
//            
//            
//            
//            CCLabelTTF *achievementLabelText = [CCLabelTTF labelWithString:@"你现在的成就是：" fontName:@"Arial" fontSize:32];
//            achievementLabelText.color = ccc3(0,0,0);
//            [achievementLabelText setPosition:ccp(1*screenSize.width/5,screenSize.height*3/6)];
//            
//            
//            CCLabelTTF *achievementText = [CCLabelTTF labelWithString:@"小有成就" fontName:@"Arial" fontSize:16];
//            achievementLabelText.color = ccc3(0,0,0);
//            [achievementText setPosition:ccp(1*screenSize.width/5,screenSize.height*2/6)];
//            
//            
//            [self addChild:levelLabelText];
//            [self addChild:levelText];
//            [self addChild:achievementLabelText];
//            [self addChild:achievementText];
//
//        }else {
//            CCLabelTTF *blockText = [CCLabelTTF labelWithString:@"你还没有通过第一关：" fontName:@"Arial" fontSize:16];
//            blockText.color = ccc3(0,0,0);
//            [blockText setPosition:ccp(3*screenSize.width/5,screenSize.height*3/5)];
//             [self addChild:blockText];
//        }
//        
//        CCLabelTTF *backButtonLabel = [CCLabelTTF labelWithString:@"Back" fontName:@"Arial" fontSize:16];
//        backButtonLabel.color = ccc3(0,0,0);
//         [backButtonLabel setPosition:ccp(1*screenSize.width/2,screenSize.height*3/6)];
//        
//        [self addChild:backButtonLabel];
        
        CCSpriteBatchNode *spritesBgNode = [CCSpriteBatchNode batchNodeWithFile:@"score.pvr.ccz"];
        [self addChild:spritesBgNode z:101];
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"score.plist"];
        
        NSArray *images = [NSArray arrayWithObjects:@"zhiscore.png",@"xinscore.png", @"renscore.png",@"yongscore.png",@"yiscore.png",nil];

        
        
        CCLabelTTF *achievementLabelText = [CCLabelTTF labelWithString:@"你当前的成就：" fontName:@"Arial" fontSize:32];
                   achievementLabelText.color = ccc3(0,0,0);
        [achievementLabelText setPosition:ccp(2*screenSize.width/5,screenSize.height*5/6)];
        [self addChild:achievementLabelText];
        
        for (int i=0;i<(level/2);i++) {
            NSString* name = images[i];
            CCLOG(@"name of %i picture is:%@",i,name);
            CCSprite *sprite = [CCSprite spriteWithSpriteFrameName:name];
            if (i<2) {
                [sprite setPosition:ccp((i+1)*100,300)];
            }
            
            if (i>=2 && i<4) {
                [sprite setPosition:ccp((i-1)*100,200)];

            }
            if (i==4) {
                 [sprite setPosition:ccp(100,100)];
            }
            
            [spritesBgNode addChild:sprite];
        }
        
        self.isTouchEnabled=YES;

		
	}
	return self;
}

- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self returnToMainMenu];
}


-(void)returnToMainMenu {
	[[GameManager sharedGameManager] runSceneWithID:kMainMenuScene];
}

@end
