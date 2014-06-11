//
//  PageViewController.m
//  BePost
//
//  Created by 横関秀樹 on 2014/05/30.
//  Copyright (c) 2014年 Hideki yokozeki. All rights reserved.
//

#import "PageViewController.h"
#import "ViewController.h"

@interface PageViewController (){
    
    UIPageViewController* pvc;
    NSInteger index;
    

}

@end

@implementation PageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    pvc = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    pvc.delegate = self;
    pvc.dataSource = self;
    
    index = 0;
    ViewController *ivc = [self viewControllerAtIndex:index storyboard:self.storyboard];
    
    NSArray *vcs = @[ivc];
    [pvc setViewControllers:vcs direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:NULL];
    
    [self addChildViewController:pvc];
    [self.view addSubview:pvc.view];
}

- (ViewController *)viewControllerAtIndex:(NSInteger)i storyboard:(UIStoryboard *)storyboard
{
    ViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"Label"];
    return vc;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    index++;
    return [self viewControllerAtIndex:index storyboard:self.storyboard];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    index--;
    return [self viewControllerAtIndex:index storyboard:self.storyboard];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
