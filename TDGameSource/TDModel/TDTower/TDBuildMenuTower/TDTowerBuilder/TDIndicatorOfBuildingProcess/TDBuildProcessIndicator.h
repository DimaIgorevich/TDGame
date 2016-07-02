//
//  TDBuildProcessIndicator.h
//  TowerDefense
//
//  Created by dRumyankov on 5/17/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TDBuildProcessIndicator : NSObject{
    CCSprite *skinIndicator_;
    
    NSTimer *intervalBetweenRotation_;
}

@property CCSprite *indicatorProcess;

- (id)initWithPoint:(CGPoint)position;

- (void)finishBuild;

@end
