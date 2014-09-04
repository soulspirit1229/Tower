
#import <Foundation/Foundation.h>
#import "Constants.h"

@interface GameManager : NSObject {
    BOOL isMusicON;
    BOOL isSoundEffectsON;
    BOOL hasPlayerDied;
    SceneTypes currentScene;
    
    SceneTypes curLevel;
    SceneTypes lastLevel;
}
@property (readwrite) BOOL isMusicON;
@property (readwrite) BOOL isSoundEffectsON;
@property (readwrite) BOOL hasPlayerDied;
@property (assign) SceneTypes curLevel; //user play now level, it is can lower than lastlevel
@property (assign) SceneTypes lastLevel;//user's history, the deepest level

+(GameManager*)sharedGameManager;// 1
+(SceneTypes) levelToSceneType:(int) level;
+(void) startGame ;
+(void) configMusicEffect;
+(void) configMusic;
-(void)runSceneWithID:(SceneTypes)sceneID;                         // 2
@end
