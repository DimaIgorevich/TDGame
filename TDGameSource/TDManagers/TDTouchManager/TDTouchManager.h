//
//  TDTouchManager.h
//  Test
//
//  Created by dRumyankov on 6/24/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TDTiledMapCell.h"

@interface TDTouchManager : NSObject

+ (TDTiledMapCell *)constractionCellByPoint:(CGPoint)location;

@end
