//
//  BuildProtocol.h
//  TowerDefense
//
//  Created by dRumyankov on 5/16/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TDItemTower.h"

@protocol TDBuildProtocol <NSObject>

@required
- (void)runBuildObject:(TDItemTower *)typeTower;

@end