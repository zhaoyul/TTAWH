//
//  GameViewController.m
//  TTAWH
//
//  Created by Zhaoyu Li on 30/4/2017.
//  Copyright © 2017 Zhaoyu Li. All rights reserved.
//

#import "GameViewController.h"
#import "FirstScene.h"

@implementation GameViewController

-(void)createUserGuide{
    UIWindow *window = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
    NSArray *imageArray = @[NSLocalizedString(@"image1", nil),
                            NSLocalizedString(@"image2", nil),
                            NSLocalizedString(@"image3", nil),
                            NSLocalizedString(@"image4", nil)];
//    DHGuidePageHUD *guidePage = [[DHGuidePageHUD alloc] dh_initWithFrame:window.frame imageArray:imageArray buttonIsHidden:YES];
    DHGuidePageHUD *guidePage = [[DHGuidePageHUD alloc] dh_initWithFrame:window.frame imageNameArray:imageArray buttonIsHidden:NO];
    [window addSubview:guidePage];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // Load the SKScene from 'GameScene.sks'
    FirstScene *scene = (FirstScene *)[SKScene nodeWithFileNamed:@"First"];
    
    // Set the scale mode to scale to fit the window
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    scene.parentVC = self;
    
    SKView *skView = (SKView *)self.view;
    
    // Present the scene
    [skView presentScene:scene];
    
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    

}

-(void)viewDidAppear:(BOOL)animated{
    // 使用NSUserDefaults判断程序是否第一次启动(其他方法也可以)
    if (![[NSUserDefaults standardUserDefaults] boolForKey:BOOLFORKEY]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:BOOLFORKEY];
        // 在这里写初始化图片数组和DHGuidePageHUD库引导页的代码
        [self createUserGuide];
    }
}

- (BOOL)shouldAutorotate {
    return YES;
}



- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
