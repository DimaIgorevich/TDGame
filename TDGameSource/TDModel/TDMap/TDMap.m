//
//  TDMap.m
//  TowerDefense
//
//  Created by dRumyankov on 4/26/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

#import "TDMap.h"

@implementation TDMap

- (id)initWithDelegate:(id)delegate{
    if(self = [super init]){
        delegate_ = delegate;
        
        _map = [[NSMutableArray alloc] init];
        
        for(int i = 0; i < [MapScheme hMapScheme]; i++){
            for(int j = 0; j < [MapScheme wMapScheme]; j++){
                [_map addObject:[[TDMapCell alloc] initWithType:[MapScheme cellByIndexs:i y:j] position:CGPointMake(j * [TDMapCell sizeMapCell].width, i * [TDMapCell sizeMapCell].height)]];
            }
        }
    }
    return self;
}

- (void)render{
    CCScene *delegateScene = delegate_;
    
    
    for(TDMapCell *objectCell in _map){
                if([delegateScene.children indexOfObject:[objectCell displayChild]] != NSNotFound){
                    [delegateScene removeChild:[objectCell displayChild]];
                }
                [delegateScene addChild:[objectCell displayChild] z: 0];

//        if([delegateScene.children indexOfObject:[objectCell displayChild]] != NSNotFound){
//            [delegateScene removeChild:[objectCell displayChild]];
//        }
//        [delegateScene addChild:[objectCell displayChild] z: 0];
    }
}

+ (CGSize)sizeMap{
    return CGSizeMake([MapScheme wMapScheme]*[TDMapCell sizeMapCell].width, [MapScheme hMapScheme]*[TDMapCell sizeMapCell].height);
}

- (void)recognizeCellTouch:(CGPoint)touchPoint{
    NSInteger positionX = touchPoint.x / [TDMapCell sizeMapCell].width;
    NSInteger positionY = touchPoint.y / [TDMapCell sizeMapCell].height;
    
    touchPoint = CGPointMake(positionX * [TDMapCell sizeMapCell].width, positionY * [TDMapCell sizeMapCell].height);
    
    for(TDMapCell *objectCell in _map){
        if([self equalPoint:[objectCell cellPosition] withPoint:touchPoint]){
            NSLog(@"find cell");
            NSLog(@"info about cell: type %d", [objectCell cellType]);
        }
    }
    
}

- (TDMapCell *)cellTouchOnPoint:(CGPoint)touchPoint{

    touchPoint = [self correctivePoint:touchPoint];
    
    TDMapCell *touchedCell;
    
    for(TDMapCell *objectCell in _map){
        if([self equalPoint:[objectCell cellPosition] withPoint:touchPoint]){
//            NSLog(@"find cell");
//            NSLog(@"info about cell: type %d", [objectCell cellType]);
                        NSLog(@"position x %f y %f", [objectCell cellPosition].x, [objectCell cellPosition].y);
            touchedCell = objectCell;
        }
    }
    
    return touchedCell;
}

- (CGPoint)correctivePoint:(CGPoint)point{
    NSInteger positionX = point.x / [TDMapCell sizeMapCell].width;
    NSInteger positionY = point.y / [TDMapCell sizeMapCell].height;
    point = CGPointMake(positionX * [TDMapCell sizeMapCell].width, positionY * [TDMapCell sizeMapCell].height);
    return point;
}

- (BOOL)equalPoint:(CGPoint)pointLeft withPoint:(CGPoint)pointRight{
    if(pointLeft.x == pointRight.x && pointLeft.y == pointRight.y){
        return YES;
    }
    return NO;
}

@end
