#import "MainScene.h"
#import "TDMenuScene.h"

@implementation MainScene

- (void)start:(id)sender{
    NSLog(@"start");
    CCScene *loadView = [CCBReader loadAsScene:@"TDLoadScene"];
    [[CCDirector sharedDirector] replaceScene:loadView];
//    CCScene *game = [[TDMenuScene alloc] init];
//    [[CCDirector sharedDirector] replaceScene:game];
    
}

- (void)credits:(id)sender{
    NSLog(@"credits");
    CCScene *creditsScene = [CCBReader loadAsScene:@"TDCredits"];
    [[CCDirector sharedDirector] replaceScene:creditsScene];
}

@end
