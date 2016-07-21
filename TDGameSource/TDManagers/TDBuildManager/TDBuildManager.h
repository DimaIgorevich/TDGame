//
//  TDBuildManager.h
//  TowerDefense
//
//  Created by dRumyankov on 5/23/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TDBuildMenu.h"
#import "TDBuildProtocol.h"
#import "TDCloseProtocol.h"
#import "TDTower.h"

@interface TDBuildManager : NSObject <TDCloseProtocol>{
    id<TDBuildProtocol> delegate_;
    TDBuildMenu *buildMenu_;
    CGPoint showPoint_;
}

- (id)initWithDelegate:(id)delegate;

- (void)showBuildMenu:(CGPoint)showPoint;
- (void)showBuildMenuForTower:(TDTower *)tower inShowPoint:(CGPoint)showPoint;

- (void)hideBuildMenu;

- (BOOL)isShowBuildMenu;
- (CGPoint)menuPosition;
- (NSArray *)dataByTower:(TDTower *)objectTower;

@end


