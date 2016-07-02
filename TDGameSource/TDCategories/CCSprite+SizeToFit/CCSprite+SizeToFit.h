//
//  CCSprite+SizeToFit.h
//  TowerDefense
//
//  Created by dRumyankov on 5/19/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

#import "CCSprite.h"

@interface CCSprite (SizeToFit)

- (void)sizeToFit32;

- (void)sizeToCustomFit:(CGSize)size;

@end
