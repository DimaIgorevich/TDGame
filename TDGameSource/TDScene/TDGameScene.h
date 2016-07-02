//
//  TDMainMenu.h
//  TowerDefense
//
//  Created by dRumyankov on 4/21/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

#import "CCScene.h"
#import "TDStatusBar.h"

@interface TDGameScene : CCScene

@property (nonatomic) CCGLView *ccglView;
@property (nonatomic) UIPinchGestureRecognizer *pinch;

@property (nonatomic) TDStatusBar *statusBar;

@property (nonatomic) NSTimer *renderTimer;

- (void)startRenderTimer;

@end
