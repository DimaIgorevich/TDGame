//
//  TDLifeIndicator.h
//  TowerDefense
//
//  Created by dRumyankov on 5/24/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

#import "CCSprite.h"

@interface TDLifeIndicator : CCSprite{
    CCSprite *progress_;
}

@property (nonatomic) NSInteger fullHitPoint;

- (id)initWithFullHitPoint:(NSInteger)hitPoint;

- (void)correctiveLifeValue:(NSInteger)value;

@end
