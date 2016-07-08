//
//  TDBuildManager.m
//  TowerDefense
//
//  Created by dRumyankov on 5/23/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

#import "TDBuildManager.h"
#import "TDObject.h"
#import "TDTowerJSON.h"
#import "TDJSONObjects.h"

#define kUpgradeObjects @"upgradeObjects"
#define kBuildingObjects @"buildingObjects"

@implementation TDBuildManager{
    NSArray <TDTowerJSON *> *jsonTowers_;
    NSDictionary *upgradeBranches_;
}

- (id)initWithDelegate:(id)delegate{
    if(self = [super init]){
        delegate_ = delegate;
        
        id json = [TDJSONObjects jsonObjectsFromFile:@"info"];
        jsonTowers_ = [TDObject arrayOfObjectsOfClass:[TDTowerJSON class] fromJSON:[json objectForKey:kBuildingObjects]];
        upgradeBranches_ = [self upgradeBranchesFromJSONFile];
        
    }
    return self;
}

- (NSDictionary *)upgradeBranchesFromJSONFile{
    id json = [TDJSONObjects jsonObjectsFromFile:@"info"];
    id upgrageBranches = [json objectForKey:kUpgradeObjects];
    
    NSMutableDictionary *upgrades = [[NSMutableDictionary alloc] init];
    for(NSString *branch in upgrageBranches){
        NSString *key = [NSString stringWithFormat:@"%d", (int)[TDTypeItem stringValueToType:branch]];
        [upgrades setObject:[self createUpgradeBranch:[upgrageBranches objectForKey:branch]] forKey:key];
    }
    return upgrades;
}

- (NSDictionary *)createUpgradeBranch:(NSDictionary *)dictionary{
    NSMutableDictionary *branch = [[NSMutableDictionary alloc] init];
    NSArray <TDTowerJSON *>* jsonTowers = [TDObject arrayOfObjectsOfClass:[TDTowerJSON class] fromJSON:dictionary];
    for(TDTowerJSON *tower in jsonTowers){
        NSString *key = [NSString stringWithFormat:@"%d", (int)tower.upgradeLevel];
        [branch setObject:tower forKey:key];
    }
    return branch;
}

//
- (void)showBuildMenu:(CGPoint)showPoint{
    //buildMenu_ = [[TDBuildMenu alloc] initWithManager:self];
    
    [self initBuildMenuWithTowers:jsonTowers_];
    showPoint_ = showPoint;
    
    [self prepareBuildMenu];
    [buildMenu_ show];
}

- (void)showBuildMenuForTower:(TDTower *)tower inShowPoint:(CGPoint)showPoint{
    NSArray *towers = [NSArray arrayWithObjects:[self dataByTower:tower], nil];
    [self initBuildMenuWithTowers:towers];
    showPoint_ = showPoint;
    
    [self prepareBuildMenu];
    [buildMenu_ show];
}

- (void)initBuildMenuWithTowers:(NSArray *)towers{
    buildMenu_ = [[TDBuildMenu alloc] initWithJSONObjects:towers manager:self];
}

- (void)prepareBuildMenu{
    buildMenu_.delegate = delegate_;
    CGPoint adaptivePoint = [TDBuildMenu showFrame:showPoint_].origin;
    buildMenu_.positionType = CCPositionTypeUIPoints;
    buildMenu_.position = CGPointMake(adaptivePoint.x, adaptivePoint.y);
}

- (void)hideBuildMenu{
    [buildMenu_ hide];
    buildMenu_ = nil;
}

- (BOOL)isShowBuildMenu{
    return buildMenu_ != nil;
}

- (CGPoint)menuPosition{
    return showPoint_;
}

- (TDTowerJSON *)dataByTower:(TDTower *)objectTower{
    NSString *keyBranch = [NSString stringWithFormat:@"%d", [objectTower typeTower]];
    NSDictionary *updateBranch = [upgradeBranches_ objectForKey:keyBranch];
    NSString *keyBranchUpgrade = [NSString stringWithFormat:@"%d", (int)[objectTower upgradeLevel]];
    return [updateBranch objectForKey:keyBranchUpgrade];
}

#pragma mark - TDCloseProtocol

- (void)dismiss{
    [self hideBuildMenu];
}

@end
