//
//  OptionsLayer.m
//  SpaceViking
//

#import "OptionsLayer.h"


@implementation OptionsLayer

-(void)returnToMainMenu {
	[[GameManager sharedGameManager] runSceneWithID:kMainMenuScene];
}


-(void)musicTogglePressed {
	if ([[GameManager sharedGameManager] isMusicON]) {
		CCLOG(@"OptionsLayer-> Turning Game Music OFF");
		[[GameManager sharedGameManager] setIsMusicON:NO];
	} else {
		CCLOG(@"OptionsLayer-> Turning Game Music ON");
		[[GameManager sharedGameManager] setIsMusicON:YES];
	}
     [GameManager configMusic];
}

-(void)SFXTogglePressed {
	if ([[GameManager sharedGameManager] isSoundEffectsON]) {
		CCLOG(@"OptionsLayer-> Turning Sound Effects OFF");
		[[GameManager sharedGameManager] setIsSoundEffectsON:NO];
	} else {
		CCLOG(@"OptionsLayer-> Turning Sound Effects ON");
		[[GameManager sharedGameManager] setIsSoundEffectsON:YES];
	}
    [GameManager configMusicEffect];
}

-(id)init {
	self = [super init];
	if (self != nil) {
		CGSize screenSize = [CCDirector sharedDirector].winSize; 
		
		CCSprite *background = [CCSprite spriteWithFile:@"settingbackground.png"];
        [background setPosition:ccp(screenSize.width/2,
                                    screenSize.height/2)];

		[self addChild:background];
		
		
        CCMenuItemImage *openMusicButton = [CCMenuItemImage
                                           itemFromNormalImage:@"openmusic.png"
                                           selectedImage:@"openmusic.png"
                                           disabledImage:nil
                                           target:self
                                           selector:nil];
        
        CCMenuItemImage *closeMusicButton = [CCMenuItemImage
                                           itemFromNormalImage:@"closemusic.png"
                                           selectedImage:@"closemusic.png"
                                           disabledImage:nil
                                           target:self
                                           selector:nil];
        
        CCMenuItemImage *openEffectButton = [CCMenuItemImage
                                            itemFromNormalImage:@"openeffect.png"
                                            selectedImage:@"openeffect.png"
                                            disabledImage:nil
                                            target:self
                                            selector:nil];
        
        CCMenuItemImage *closeEffectButton = [CCMenuItemImage
                                             itemFromNormalImage:@"closeeffect.png"
                                             selectedImage:@"closeeffect.png"
                                             disabledImage:nil
                                             target:self
                                             selector:nil];
        
        
        CCMenuItemImage *backButton = [CCMenuItemImage
                                              itemFromNormalImage:@"back.png"
                                              selectedImage:@"back.png"
                                              disabledImage:nil
                                              target:self
                                              selector:@selector(returnToMainMenu)];

        
        
//		CCLabelTTF *musicOnLabelText = [CCLabelTTF labelWithString:@"Music ON" fontName:@"Arial" fontSize:16];
//        musicOnLabelText.color = ccc3(0,0,0);
//		//musicOnLabelText.position = ccp(screenSize.width/2, screenSize.height/2);
//        
//
//        
//		CCLabelTTF *musicOffLabelText = [CCLabelTTF labelWithString:@"Music OFF" fontName:@"Arial" fontSize:16];
//        musicOffLabelText.color = ccc3(0,0,0);
//
//        
//        
//		CCLabelTTF *SFXOnLabelText = [CCLabelTTF labelWithString:@"Sound Effects ON" fontName:@"Arial" fontSize:16];
//        SFXOnLabelText.color = ccc3(0,0,0);
//
//        
//		CCLabelTTF *SFXOffLabelText = [CCLabelTTF labelWithString:@"Sound Effects OFF" fontName:@"Arial" fontSize:16];
//        SFXOffLabelText.color = ccc3(0,0,0);
//
//        
//        CCLabelTTF *backButtonLabel = [CCLabelTTF labelWithString:@"Back" fontName:@"Arial" fontSize:16];
//        backButtonLabel.color = ccc3(0,0,0);
//		
//		CCMenuItemLabel *musicOnLabel = [CCMenuItemLabel itemWithLabel:musicOnLabelText target:self selector:nil];
//		CCMenuItemLabel *musicOffLabel = [CCMenuItemLabel itemWithLabel:musicOffLabelText target:self selector:nil];
//		CCMenuItemLabel *SFXOnLabel = [CCMenuItemLabel itemWithLabel:SFXOnLabelText target:self selector:nil];
//		CCMenuItemLabel *SFXOffLabel = [CCMenuItemLabel itemWithLabel:SFXOffLabelText target:self selector:nil];
//
//										 
//		CCMenuItemToggle *musicToggle = [CCMenuItemToggle itemWithTarget:self 
//																selector:@selector(musicTogglePressed) 
//																   items:musicOnLabel,musicOffLabel,nil];
//		
//		CCMenuItemToggle *SFXToggle = [CCMenuItemToggle itemWithTarget:self 
//																selector:@selector(SFXTogglePressed) 
//																   items:SFXOnLabel,SFXOffLabel,nil];
//        
//        CCMenuItemLabel	*backButton = [CCMenuItemLabel itemWithLabel:backButton target:self selector:@selector(returnToMainMenu)];
        

        CCMenuItemToggle *musicToggle = [CCMenuItemToggle itemWithTarget:self
        																selector:@selector(musicTogglePressed)
        															   items:openMusicButton,closeMusicButton,nil];
        
        CCMenuItemToggle *SFXToggle = [CCMenuItemToggle itemWithTarget:self
                                                                selector:@selector(SFXTogglePressed)
                                                                   items:openEffectButton,closeEffectButton,nil];
        
        
		
        
		
			
		CCMenu *optionsMenu = [CCMenu menuWithItems:musicToggle,
							   SFXToggle,
							   backButton,nil];
		[optionsMenu alignItemsVerticallyWithPadding:60.0f];
		[optionsMenu setPosition:ccp(screenSize.width * 0.5f, screenSize.height/2)];
		[self addChild:optionsMenu];
        
        if ([[GameManager sharedGameManager] isMusicON] == NO) {
            [musicToggle setSelectedIndex:1]; // Music is OFF
        }
        
        if ([[GameManager sharedGameManager] isSoundEffectsON] == NO) {
            [SFXToggle setSelectedIndex:1]; // SFX are OFF
        }
	}
	return self;
}
@end
