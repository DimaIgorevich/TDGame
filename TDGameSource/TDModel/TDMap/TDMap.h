//
//  TDMap.h
//  TowerDefense
//
//  Created by dRumyankov on 4/26/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MapScheme.h"

@interface TDMap : NSObject {
    id delegate_;
}

@property NSMutableArray <TDMapCell *> *map;

- (id)initWithDelegate:(id)delegate;

- (void)render;

//- (void)recognizeCellTouch:(CGPoint)touchPoint;
- (TDMapCell *)cellTouchOnPoint:(CGPoint)touchPoint;
+ (CGSize)sizeMap;

@end
