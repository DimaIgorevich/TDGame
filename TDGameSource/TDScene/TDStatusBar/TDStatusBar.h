//
//  TDStatusBar.h
//  Test
//
//  Created by dRumyankov on 6/15/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

#import "CCNode.h"
#import "TDPauseProtocol.h"
#import "TDSetGameSceneProtocol.h"

@interface TDStatusBar : CCNode <TDSetGameSceneProtocol>

@property (nonatomic) BOOL isShow;
@property (nonatomic) id<TDPauseProtocol> gameScene;

@property (nonatomic) CCLabelTTF *coins;
@property (nonatomic) CCLabelTTF *health;
@property (nonatomic) CCLabelTTF *timer;
@property (nonatomic) CCLabelTTF *waves;

- (void)animationNoMoney;
- (void)setNumberWave:(NSInteger)numberWave ofWaves:(NSInteger)countWaves;

@end
