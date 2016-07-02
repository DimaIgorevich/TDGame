//
//  CCNode+CoordHelpers.m
//  TowerDefense
//
//  Created by dRumyankov on 5/20/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

#import "CCNode+CoordHelpers.h"

@implementation CCNode (CoordHelpers)

-(CGRect)worldBoundingBox {
    CGRect rect = CGRectMake(0, 0, _contentSize.width, _contentSize.height);
    return CGRectApplyAffineTransform(rect, [self nodeToWorldTransform]);
}

@end
