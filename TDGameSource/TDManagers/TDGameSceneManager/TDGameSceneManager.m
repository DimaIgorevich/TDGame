//
//  TDGameSceneManager.m
//  Test
//
//  Created by dRumyankov on 6/30/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

#import "TDGameSceneManager.h"
#import "TDGameScene.h"
#import "TDStatusBar.h"

@implementation TDGameSceneManager

-(id)init{
    if(self = [super init]){
        //load game scene:
        TDGameScene *gameScene = [[TDGameScene alloc] init];
        
        //load status bar:
        TDStatusBar *statusBar = (TDStatusBar *)[CCBReader load:@"TDGameLayer"];
        gameScene.statusBar = statusBar;
        [self addChild:gameScene];
        
        _gameScene = gameScene;
        [statusBar setGameScene:_gameScene];
        
        [self addChild:statusBar];
        
//        NSLog(@"info coins: %@", [statusBar.coins string]);
//        [statusBar.coins setString:@"250"];
//        NSLog(@"new coins: %@", [statusBar.coins string]);
    }
    
    return self;
}



@end
