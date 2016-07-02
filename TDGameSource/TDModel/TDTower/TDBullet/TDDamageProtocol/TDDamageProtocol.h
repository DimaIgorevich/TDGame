//
//  TDDamageProtocol.h
//  TowerDefense
//
//  Created by dRumyankov on 5/23/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

#ifndef TDDamageProtocol_h
#define TDDamageProtocol_h

@protocol TDDamageProtocol <NSObject>
@required
- (void)damagedObject:(int)damage;

@end


#endif /* TDDamageProtocol_h */
