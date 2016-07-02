//
//  TDPauseMenuLayer.m
//  Test
//
//  Created by dRumyankov on 6/30/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

#import "TDPauseMenuLayer.h"
#import "TDLoadScene.h"
#import "TDPauseMenu.h"

@implementation TDPauseMenuLayer

- (void)close:(id)sender{
    _gameScene = ((TDPauseMenu *)[self parent]).gameScene;
    
    if(_gameScene){
        [_gameScene resumeSceneActions];
    }
    [self hide];
}

- (void)quit:(id)sender{
    _gameScene = ((TDPauseMenu *)[self parent]).gameScene;
    
    [_gameScene clearScene];
    
    CCScene *menuScene = [CCBReader loadAsScene:@"TDMainScene"];
    [[CCDirector sharedDirector] replaceScene:menuScene];
}

- (void)restart:(id)sender{
    _gameScene = ((TDPauseMenu *)[self parent]).gameScene;
    
    CCScene *loadScene = [CCBReader loadAsScene:@"TDLoadScene"];
    [_gameScene clearScene];
    
    [((TDLoadScene*)[loadScene.children firstObject]) startLoad];
    
    [[CCDirector sharedDirector] replaceScene:loadScene];
}

- (void)hide{
    [[self parent] removeFromParent];
}


@end
