//
//  TDStatusBar.m
//  Test
//
//  Created by dRumyankov on 6/15/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

#import "TDStatusBar.h"
#import "TDGameScene.h"
#import "TDPauseMenu.h"
#import "CCActionShake.h"

@implementation TDStatusBar{
    CCLabelTTF *coins_;
    CCLabelTTF *health_;
    CCLabelTTF *timer_;
    CCLabelTTF *waves_;
    CCLabelTTF *energy_;
}

@synthesize coins = coins_;
@synthesize health = health_;
@synthesize timer = timer_;
@synthesize waves = waves_;
@synthesize energy = energy_;

- (id)init{
    if(self = [super init]){
        _isShow = NO;
    }
    
    return self;
}

- (void)menu:(id)sender{    
    if(!_isShow){
        _isShow = YES;

        TDPauseMenu *pauseMenuScene = (TDPauseMenu *)[CCBReader load:@"TDPauseMenu"];
        pauseMenuScene.gameScene = _gameScene;
        
        CCNode *gameManager = [self parent];
        [gameManager addChild:pauseMenuScene];
        
        [_gameScene pauseSceneActions:self];
        [self hide];
    }
}

- (void)hide{
    _isShow = NO;
    [self removeFromParent];
}

- (void)animationNoEnegry{
    [energy_ runAction:[CCActionShake actionWithDuration:0.5f amplitude:CGPointMake(0.01f, 0.0f) dampening:YES]];
}

- (void)animationNoMoney{
    [coins_ runAction:[CCActionShake actionWithDuration:0.5f amplitude:CGPointMake(0.01f, 0.0f) dampening:YES]];
}

- (void)setNumberWave:(NSInteger)numberWave ofWaves:(NSInteger)countWaves{
    [waves_ setString:[NSString stringWithFormat:@"%d/%d", numberWave, countWaves]];
}

#pragma mark - TDSetGameSceneProtocol

- (void)setGameScene:(id<TDPauseProtocol>)gameScene{
    _gameScene = gameScene;
}


@end
