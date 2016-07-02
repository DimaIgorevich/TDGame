//
//  TDWaveTimerProtocol.h
//  Test
//
//  Created by dRumyankov on 7/1/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>

//Structures:
#import "TDTimeFormatStructure.h"

@protocol TDWaveTimerProtocol<NSObject>

@required
- (void)setValueTimer:(TDTime)time;

@end
