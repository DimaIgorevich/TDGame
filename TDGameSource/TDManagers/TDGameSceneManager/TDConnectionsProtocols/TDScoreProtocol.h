//
//  TDScoreProtocol.h
//  Test
//
//  Created by dRumyankov on 7/1/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TDScoreProtocol <NSObject>

@required
- (void)updateScore:(NSInteger)newScore;

@end
