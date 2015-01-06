//
//  PageView.m
//  BePost
//
//  Created by 横関秀樹 on 2014/05/30.
//  Copyright (c) 2014年 Hideki yokozeki. All rights reserved.
//

#import "PageView.h"

@interface PageView (){

    UIScrollView *scrollView;
    UIPageControl *pageControl;
    
}

@end

@implementation PageView

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    
    
    return self;
}

/**
 * スクロールビューがスワイプされたとき
 * @attention UIScrollViewのデリゲートメソッド
 */
- (void)scrollViewDidScroll:(UIScrollView *)_scrollView
{
    CGFloat pageWidth = scrollView.frame.size.width;
    if ((NSInteger)fmod(scrollView.contentOffset.x , pageWidth) == 0) {
        // ページコントロールに現在のページを設定
        pageControl.currentPage = scrollView.contentOffset.x / pageWidth;
    }
}

/**
 * ページコントロールがタップされたとき
 */
- (void)pageControl_Tapped:(id)sender
{
    CGRect frame = scrollView.frame;
    frame.origin.x = frame.size.width * pageControl.currentPage;
    [scrollView scrollRectToVisible:frame animated:YES];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Back.png"]];
    NSInteger pageSize = 3; // ページ数
    CGFloat width = self.view.bounds.size.width;
    CGFloat height = self.view.bounds.size.height;
    
    // UIScrollViewのインスタンス化
    scrollView = [[UIScrollView alloc]init];
    scrollView.frame = self.view.bounds;
    
    // 横スクロールのインジケータを非表示にする
    scrollView.showsHorizontalScrollIndicator = NO;
    
    // ページングを有効にする
    scrollView.pagingEnabled = YES;
    
    scrollView.userInteractionEnabled = YES;
    scrollView.delegate = self;
    
    // スクロールの範囲を設定
    [scrollView setContentSize:CGSizeMake((pageSize * width), height)];
    
    // スクロールビューを貼付ける
    [self.view addSubview:scrollView];
    
    // スクロールビューにラベルを貼付ける
    for (int i = 0; i < pageSize; i++) {
        UITextView *label = [[UITextView alloc]initWithFrame:CGRectMake(58, 224, 204, 250)];
        label.backgroundColor = [UIColor grayColor];
        UIView* view = [[UIView alloc]initWithFrame:CGRectMake(i*width,0,width,height)];
        UIImageView* imageView = [[UIImageView alloc]initWithFrame:CGRectMake(58, 20, 204, 204)];
        UIImage* explainImage = [UIImage imageNamed:[NSString stringWithFormat:@"explain%d.png",i]];
        view.alpha = 0.7;
        
        imageView.image = explainImage;
        //label.backgroundColor = [UIColor yellowColor];
        view.backgroundColor = [UIColor grayColor];
        
        label.font = [UIFont fontWithName:@"Arial" size:20];
        label.editable = NO;
        switch (i) {
            case 0:
                //NSLocalizedString
                label.text = NSLocalizedString(@"Turn On Bluetooth and LocationService. After that, Choose your ID you want to send by flick left or right.",nil);
                break;
            case 1:
                label.text = NSLocalizedString(@"By flick up, Mode will be changed to ID Sending Mode. You need to pu BePostID before sending.",nil);
                break;
            case 2:
                label.text = NSLocalizedString(@"By flick down, Mode will be changed to ID Recieving Mode.",nil);
                break;
            default:
                break;
        }
        
        [view addSubview:label];
        [view addSubview:imageView];
        [scrollView addSubview:view];
        
        //label.font = [UIFont fontWithName:@"Arial" size:20];
        
        
    }
    
    // ページコントロールのインスタンス化
    CGFloat x = (width - 300) / 2;
    pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(x, 440, 300, 50)];
    
    // ページ数を設定
    pageControl.numberOfPages = pageSize;
    
    // 現在のページを設定
    pageControl.currentPage = 0;
    
    // ページコントロールをタップされたときに呼ばれるメソッドを設定
    pageControl.userInteractionEnabled = YES;
    [pageControl addTarget:self
                    action:@selector(pageControl_Tapped:)
          forControlEvents:UIControlEventValueChanged];
    
    // ページコントロールを貼付ける
    [self.view addSubview:pageControl];
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
