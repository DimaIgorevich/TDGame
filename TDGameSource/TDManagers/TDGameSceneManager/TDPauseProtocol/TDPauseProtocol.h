//
//  TDPauseProtocol.h
//  Test
//
//  Created by dRumyankov on 6/30/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TDPauseProtocol <NSObject>

@required
- (void)pauseSceneActions:(id)sender;
- (void)clearScene;
- (void)resumeSceneActions;

@end