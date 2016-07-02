//
//  TDSlayer.h
//  TowerDefense
//
//  Created by dRumyankov on 4/22/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

#import "TDEnemy.h"

@interface TDSlayer : TDEnemy

- (id)initWithRespawnPoint:(CGPoint)respawnPoint delegate:(id)delegate;

@end
