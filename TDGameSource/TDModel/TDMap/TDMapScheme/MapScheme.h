//
//  MapScheme.h
//  TowerDefense
//
//  Created by dRumyankov on 4/26/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TDMapCell.h"

@interface MapScheme : NSObject

+ (int)cellByIndexs:(int)x y:(int)y;

+ (NSInteger)hMapScheme;

+ (NSInteger)wMapScheme;

@end
