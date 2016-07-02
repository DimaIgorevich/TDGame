//
//  TDWaveTimerManager.m
//  Test
//
//  Created by dRumyankov on 7/1/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

#import "TDWaveTimerManager.h"

@implementation TDWaveTimerManager{
    NSTimer *timer;
}

- (void)initTimer:(NSInteger)seconds{
    pauseSeconds_ = seconds;
    
    timer = [NSTimer scheduledTimerWithTimeInterval:1.f target:self selector:@selector(countdown) userInfo:nil repeats:YES];
}

- (void)countdown{
    
    if(pauseSeconds_ < 0){
        [timer invalidate];
        timer = nil;
    }
    
    if(pauseSeconds_ != -1){
        [_delegate setValueTimer:[self timeToFormat:pauseSeconds_]];
    }
    
    pauseSeconds_--;
}

- (TDTime)timeToFormat:(NSInteger)seconds{
    TDTime formatTime;
    
    NSInteger min = 0;
    NSInteger sec = seconds;
    
    for(int i = 0; sec > 60; i++){
        min++;
        sec -= 60;
    }
    
    sec = seconds - min * 60;
    
    formatTime.minutes = min;
    formatTime.seconds = sec;
    
    return formatTime;
}

@end
