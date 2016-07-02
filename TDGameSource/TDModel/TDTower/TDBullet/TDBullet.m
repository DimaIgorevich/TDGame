//
//  TDBullet.m
//  TowerDefense
//
//  Created by dRumyankov on 5/20/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

#import "TDBullet.h"
#import "CCNode+CoordHelpers.h"

#define kBulletSkin @"td_bullet.png"

@implementation TDBullet

@synthesize speed = speed_;
@synthesize damage = damage_;

- (id)initWithCharacteristicBullet:(TDBulletCharacter)characteristicBullet spawner:(id)spawner target:(id)target{
    if(self = [super initWithImageNamed:kBulletSkin]){
        speed_ = characteristicBullet.speed;
        damage_ = characteristicBullet.damage;
        
        spawner_ = spawner;
        target_ = target;
        
        self.anchorPoint = CGPointZero;
        
    }
    return  self;
}

- (void)draw{
    self.position = spawner_.position;
    [spawner_.delegate addChild:self];
    
    CGPoint targetPoint = [self correctiveTargetPoint];
    CGFloat actionDuration = [self calculateDurationOfMove:targetPoint];
    
    
    [self runAction:[CCActionMoveTo actionWithDuration:actionDuration position:targetPoint]];
    //[self runAction:[CCActionMoveTo actionWithDuration:actionDuration position:target_.position]];
    
    [NSTimer scheduledTimerWithTimeInterval:actionDuration target:self selector:@selector(removeBullet) userInfo:nil repeats:NO];
    
    updateTimer_ = [NSTimer scheduledTimerWithTimeInterval:0.01f target:self selector:@selector(checkTarget) userInfo:nil repeats:YES];
}

- (void)checkTarget{
    if([self isTarget]){
        [self actionBumpTarget];
    }
}

- (void)actionBumpTarget{
    //NSLog(@"DAMAGE");
    
    [target_ damagedObject:damage_];
    
    //[self cleanup];
    [self removeFromParent];
    
    [updateTimer_ invalidate];
    updateTimer_ = nil;
}

- (BOOL)isTarget{
    
    CGRect bulletRect = [self worldBoundingBox];
    //bulletRect.origin.x -= bulletRect.size.width;
    bulletRect.origin.y -= bulletRect.size.height/2;
    
    return !CGRectIsNull(CGRectIntersection([[target_ sprite] worldBoundingBox], bulletRect));
}

- (CGPoint)correctiveTargetPoint{
    CGPoint position = target_.position;
    CGFloat actionDuration = [self calculateDurationOfMove:position];
    CGFloat offset = [target_ speedMotion]*actionDuration*0.1f;
    //NSLog(@"offset: dx/dy: %f", offset);
    
    if([target_ currentDirection] == kMovingUp){
        position.y += offset;
    } else if([target_ currentDirection] == kMovingDown){
        position.y -= offset;
    } else if([target_ currentDirection] == kMovingLeft){
        position.x -= offset;
    } else if([target_ currentDirection] == kMovingRigth){
        position.x += offset;
    }
    
    return position;
}

- (CGFloat)calculateDurationOfMove:(CGPoint)targetPosition{
    CGFloat dx = targetPosition.x - spawner_.position.x;
    CGFloat dy = targetPosition.y - spawner_.position.y - self.boundingBox.size.height;
    CGFloat lengthWay = sqrtf(powf(dx,2) + powf(dy, 2));
    CGFloat timeAction = lengthWay/speed_;
    
    return timeAction;
}

- (void)removeBullet{
    if(updateTimer_ != nil){
       // [self cleanup];
        [self removeFromParent];
    }
}

@end
