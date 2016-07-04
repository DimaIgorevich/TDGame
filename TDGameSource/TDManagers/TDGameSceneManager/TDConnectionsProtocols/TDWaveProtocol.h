//
//  TDWaveProtocol.h
//  Test
//
//  Created by dRumyankov on 7/1/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TDWaveProtocol <NSObject>

@required
- (void)setNumberWave:(NSInteger)number ofWaves:(NSInteger)countWaves;

- (void)finishScreen;

@end