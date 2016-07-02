//
//  TDWaveTimerManager.h
//  Test
//
//  Created by dRumyankov on 7/1/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TDWaveTimerProtocol.h"

@interface TDWaveTimerManager : NSObject{
    NSInteger pauseSeconds_;
}

- (void)initTimer:(NSInteger)seconds;

@property (nonatomic) id<TDWaveTimerProtocol> delegate;

@end
