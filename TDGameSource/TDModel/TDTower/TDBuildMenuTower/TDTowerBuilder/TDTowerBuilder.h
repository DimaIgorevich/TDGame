//
//  TDTowerBuilder.h
//  TowerDefense
//
//  Created by dRumyankov on 5/19/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TDTowerBuilder : NSObject{
    CCSprite *buildSprite_;
}

@property (nonatomic) CGPoint buildPosition;
@property (nonatomic) CCScene *delegate;

- (CGFloat)run;

@end
