//
//  CCSprite+SizeToFit.m
//  TowerDefense
//
//  Created by dRumyankov on 5/19/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

#import "CCSprite+SizeToFit.h"

@implementation CCSprite (SizeToFit)

- (void)sizeToFit32{
    self.scaleX = 32/self.contentSize.width;
    self.scaleY = 32/self.contentSize.height;
}

- (void)sizeToCustomFit:(CGSize)size{
    self.scaleX = size.width/self.contentSize.width;
    self.scaleY = size.height/self.contentSize.height;
}

@end
