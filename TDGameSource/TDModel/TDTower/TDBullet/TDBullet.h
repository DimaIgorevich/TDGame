//
//  TDBullet.h
//  TowerDefense
//
//  Created by dRumyankov on 5/20/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

#import "CCSprite.h"
#import "TDEnemy.h"
#import "TDTower.h"
#import "TDBulletCharacterStruct.h"
#import "TDDamageProtocol.h"

@interface TDBullet : CCSprite{
    CGFloat speed_;
    CGFloat damage_;
    
    TDTower *spawner_;
    TDEnemy<TDDamageProtocol> *target_;
    
    //CGPoint targetPoint_;
    
    NSTimer *updateTimer_;
    
}

@property (nonatomic) CGFloat speed;
@property (nonatomic) CGFloat damage;

- (id)initWithCharacteristicBullet:(TDBulletCharacter)characteristicBullet spawner:(id)spawner target:(id)target;

- (void)draw;

@end
