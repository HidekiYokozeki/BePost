//
//  ViewController.m
//  AddTest
//
//  Created by 横関秀樹 on 2014/04/29.
//  Copyright (c) 2014年 Hideki yokozeki. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "SenderViewController.h"
#import "RecieverViewController.h"

@interface ViewController (){

    NSArray* array;
    BOOL MenuFlag;
    NSString* LineName;
    NSInteger CurrentNum;
    NSString* Line;
    NSString* Phones;
    NSInteger remenber_position;
    
    UIView* Line_View;
    UIView* Facebook_View;
    UIView* Phones_View;
    
    FBLoginView *loginview;
    NSString* FacebookID;
    
    UIImageView* LineImage;
    UIImageView* FacebookImage;
    UIImageView* PhonesImage;
    
    NSInteger View_y_position;
    NSString *facebookget;
    BOOL error_flag;
    NSString* userName;
    
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.serNameField.delegate = self;
    
    self.NameBox.delegate = self;
    
    [[self.PutTextView layer] setCornerRadius:5.0];
    [self.PutTextView setClipsToBounds:YES];
    
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    if(screenSize.width == 320.0 && screenSize.height == 568.0)
    {
        View_y_position = 85;
    }else{
    
        View_y_position = 0;
        
    }

    /*
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"light2.png"] drawInRect:self.view.bounds];
    UIImage *backgroundImages = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    */
    
    /*
[UINavigationBar appearance].barTintColor = [UIColor colorWithRed:0.000 green:0.549 blue:0.890 alpha:1.000];
    */
     
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Back.png"]];
    
    //self.view.backgroundColor = [UIColor colorWithPatternImage:backgroundImages];
    //self.view.backgroundColor = [UIColor colorWithRed:241.0/255 green:196.0/255 blue:15.0/255 alpha:1.0];
    //rgb(52, 152, 219)
    //rgb(211, 84, 0)
    //rgb(189, 195, 199)
    //rgb(211, 84, 0)
    //rgb(241, 196, 15)
    
    
    Line_View = [[UIView alloc] init];
    Facebook_View = [[UIView alloc] init];
    Phones_View = [[UIView alloc] init];
    
    MenuFlag = YES;
    

    
    //右スワイプイベントの設定
    [self Right_swipe_set];
    
    //左スワイプイベントの設定
    [self Left_swipe_set];
    
    //上スワイプイベントの設定
    [self Up_swipe_set];
    
    //下スワイプイベントの設定
    [self Down_swipe_set];
    

    //メニュービューの影、マスクの設定
    //[self View_Mask];
    
    
    self.sendDam.alpha = 0;
    self.RecDam.alpha = 0;
    
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    // ユーザーデフォルトから文字列配列を取得
   // NSArray *names = [userDefaults stringForKey:@"names"];
    Line = [userDefaults stringForKey:@"Line"];
    
    FacebookID = [userDefaults stringForKey:@"Facebook"];
    Phones = [userDefaults stringForKey:@"Phones"];
    remenber_position = [userDefaults integerForKey:@"remember"];
    userName = [userDefaults stringForKey:@"userName"];
    self.serNameField.text = userName;
    
    self.NameBox.text = Line;
    
    UIImage* image = [UIImage imageNamed:@"Line.png"];
    LineImage = [[UIImageView alloc] initWithImage:image];
    [LineImage setContentMode:UIViewContentModeScaleAspectFit];
    LineImage.frame = CGRectMake(0, 0, 120, 120);
    Line_View.alpha = 0.8;
    [Line_View addSubview:LineImage];
    
    image = [UIImage imageNamed:@"Facebook.png"];
    FacebookImage = [[UIImageView alloc] initWithImage:image];
    [FacebookImage setContentMode:UIViewContentModeScaleAspectFit];
    FacebookImage.frame = CGRectMake(20, 20, 80, 80);
    Facebook_View.alpha = 0.8;
    [Facebook_View addSubview:FacebookImage];
    
    image = [UIImage imageNamed:@"Address.png"];
    PhonesImage = [[UIImageView alloc] initWithImage:image];
    [PhonesImage setContentMode:UIViewContentModeScaleAspectFit];
    PhonesImage.frame = CGRectMake(10, 10, 100, 100);
    Phones_View.alpha = 0.8;
    [Phones_View addSubview:PhonesImage];
    
    
    //[self FacebookLoginMake];
}



/*
-(void) FacebookLoginMake{
    
    loginview = [[FBLoginView alloc] init];
    loginview.delegate = self;
    
    loginview.frame = CGRectOffset(loginview.frame, 51, 325+View_y_position);
    NSLog(@"%lf %lf",loginview.frame.size.width,loginview.frame.size.height);
    loginview.alpha = 0;
    
    [self.view addSubview:loginview];
    
}

// This method will be called when the user information has been fetched
- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView
                            user:(id<FBGraphUser>)user {
    
    
    FacebookID = [user objectForKey:@"link"];
    //FacebookID = user.link;
    FacebookID = [FacebookID substringFromIndex:44];
    FacebookID = [FacebookID stringByReplacingOccurrencesOfString:@"/" withString:@""];
    NSLog(@"Facebook ID = %@",FacebookID);
    
    //FacebookID = [FacebookID substringWithRange:NSMakeRange(44, FacebookID.length-1)];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:FacebookID forKey:@"Facebook"];
    [userDefaults synchronize];
 
 NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
 
 // ユーザーデフォルトから文字列配列を取得
 // NSArray *names = [userDefaults stringForKey:@"names"];
 Line = [userDefaults stringForKey:@"Line"];
 
    if(remenber_position == 250){
        self.NameBox.text = FacebookID;
        NSLog(@"Facebook ID1 = %@",FacebookID);
    }
}
*/


//ディクショナリーを呼ぶ部分
Userdefault *default;
Dic *dic;
dic = [default objectforkey:@"imagelist"];

for in(NSStirng* imagestr in dic){


}


//ディクショナリにでーたを追加する部分
NSsting imagename;
[dic setString:imagename forkey:"日付"];
userdedault default;
//実際に保存（アプリ消した後でもディクショナリー内のデータを保存するため。
[userdefault setobejct:dic forkey:@"imagelist"];



/*
//Facebook部
-(void) FacebookLoginMake{

    loginview = [[FBLoginView alloc] init];
    loginview.delegate = self;
    
    loginview.frame = CGRectOffset(loginview.frame, 51, 325+View_y_position);
    NSLog(@"%lf %lf",loginview.frame.size.width,loginview.frame.size.height);
    loginview.alpha = 0;
    
    [self.view addSubview:loginview];

}

// This method will be called when the user information has been fetched
- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView
                            user:(id<FBGraphUser>)user {
    
    FacebookID = [user objectForKey:@"link"];
    //FacebookID = user.link;
    FacebookID = [FacebookID substringFromIndex:44];
    FacebookID = [FacebookID stringByReplacingOccurrencesOfString:@"/" withString:@""];
    NSLog(@"Facebook ID = %@",FacebookID);
    
    //FacebookID = [FacebookID substringWithRange:NSMakeRange(44, FacebookID.length-1)];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:FacebookID forKey:@"Facebook"];
    [userDefaults synchronize];
    
    if(remenber_position == 250){
        self.NameBox.text = FacebookID;
        NSLog(@"Facebook ID1 = %@",FacebookID);
    }


}

// Implement the loginViewShowingLoggedInUser: delegate method to modify your app's UI for a logged-in user experience
- (void)loginViewShowingLoggedInUser:(FBLoginView *)loginView {
    
}

// Implement the loginViewShowingLoggedOutUser: delegate method to modify your app's UI for a logged-out user experience
- (void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView {
    
}


// You need to override loginView:handleError in order to handle possible errors that can occur during login
- (void)loginView:(FBLoginView *)loginView handleError:(NSError *)error {
    NSString *alertMessage, *alertTitle;
    
    // If the user should perform an action outside of you app to recover,
    // the SDK will provide a message for the user, you just need to surface it.
    // This conveniently handles cases like Facebook password change or unverified Facebook accounts.
    if ([FBErrorUtility shouldNotifyUserForError:error]) {
        alertTitle = @"Facebook error";
        alertMessage = [FBErrorUtility userMessageForError:error];
        
        // This code will handle session closures since that happen outside of the app.
        // You can take a look at our error handling guide to know more about it
        // https://developers.facebook.com/docs/ios/errors
    } else if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryAuthenticationReopenSession) {
        alertTitle = @"Session Error";
        alertMessage = @"Your current session is no longer valid. Please log in again.";
        
        // If the user has cancelled a login, we will do nothing.
        // You can also choose to show the user a message if cancelling login will result in
        // the user not being able to complete a task they had initiated in your app
        // (like accessing FB-stored information or posting to Facebook)
    } else if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryUserCancelled) {
        NSLog(@"user cancelled login");
        
        // For simplicity, this sample handles other errors with a generic message
        // You can checkout our error handling guide for more detailed information
        // https://developers.facebook.com/docs/ios/errors
    } else {
        alertTitle  = @"Something went wrong";
        alertMessage = @"Please try again later.";
        NSLog(@"Unexpected error:%@", error);
    }
    
    if (alertMessage) {
        [[[UIAlertView alloc] initWithTitle:alertTitle
                                    message:alertMessage
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil] show];
    }
}
*/
 
//Facebookここまで
- (void)viewWillAppear:(BOOL)animated{
    /*
        [UINavigationBar appearance].barTintColor = [UIColor colorWithRed:0.000 green:0.549 blue:0.890 alpha:1.000];
     */
    self.idNameLabel.textAlignment = NSTextAlignmentCenter;
    
    
    [self view_set];

}

- (void)view_set{
    
    switch (remenber_position) {
        case 100://真ん中にある時
        case   0:
            
            Line_View.frame = CGRectMake(100, 160+View_y_position, 120, 120);
            Facebook_View.frame = CGRectMake(20, 105+View_y_position, 50, 50);
            Phones_View.frame = CGRectMake(250, 105+View_y_position, 50, 50);
            
            Line_View.layer.masksToBounds = NO;
            Facebook_View.layer.masksToBounds = NO;
            Phones_View.layer.masksToBounds = NO;
            
            break;
        case 250://右にある時
            Line_View.frame = CGRectMake(250, 105+View_y_position, 50, 50);
            Facebook_View.frame = CGRectMake(100, 160+View_y_position, 120, 120);
            Phones_View.frame = CGRectMake(20, 105+View_y_position, 50, 50);
            
            Line_View.layer.masksToBounds = NO;
            Facebook_View.layer.masksToBounds = NO;
            Phones_View.layer.masksToBounds = NO;
            
            break;
        case 20://左にある時
            Line_View.frame = CGRectMake(20, 105+View_y_position, 50, 50);
            Facebook_View.frame = CGRectMake(250, 105+View_y_position, 50, 50);
            Phones_View.frame = CGRectMake(100, 160+View_y_position, 120, 120);
            
            Line_View.layer.masksToBounds = NO;
            Facebook_View.layer.masksToBounds = NO;
            Phones_View.layer.masksToBounds = NO;
            
            
            break;
            
        default:
            break;
    }
    
    Line_View.layer.cornerRadius = 10.0f;
    Facebook_View.layer.cornerRadius = 10.0f;
    Phones_View.layer.cornerRadius = 10.0f;
    
    // 影のかかる方向を指定する
    Line_View.layer.shadowOffset = CGSizeMake(10.0f, 10.0f);
    Facebook_View.layer.shadowOffset = CGSizeMake(10.0f, 10.0f);
    Phones_View.layer.shadowOffset = CGSizeMake(10.0f, 10.0f);
    
    // 影の透明度
    Line_View.layer.shadowOpacity = 0.7f;
    Facebook_View.layer.shadowOpacity = 0.7f;
    Phones_View.layer.shadowOpacity = 0.7f;
    
    // 影の色
    
    Line_View.layer.shadowColor = [UIColor blackColor].CGColor;
    Facebook_View.layer.shadowColor = [UIColor blackColor].CGColor;
    Phones_View.layer.shadowColor = [UIColor blackColor].CGColor;
    
    // ぼかしの量
    Line_View.layer.shadowRadius = 10.0f;
    Facebook_View.layer.shadowRadius = 10.0f;
    Phones_View.layer.shadowRadius = 10.0f;
    
    
    

    //オブジェクトの配色
    // 0, 204, 0
    //57, 20, 175
    //255, 211, 0

    /*
    Line_View.backgroundColor = [UIColor colorWithRed:0.0/255 green:204.0/255 blue:0.0/255 alpha:1.0];
    Facebook_View.backgroundColor = [UIColor colorWithRed:57.0/255 green:20.0/255 blue:175.0/255 alpha:1];
    Phones_View.backgroundColor = [UIColor colorWithRed:255.0/255 green:211.0/255 blue:0.0/255 alpha:1];
    */
    
    /*
    Line_View.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Line.png"]];
    Facebook_View.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Facebook.png"]];
    Phones_View.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Address.png"]];
    */
    
    
    
    [self.view addSubview:Line_View];
    [self.view addSubview:Facebook_View];
    [self.view addSubview:Phones_View];
    
    [self positionEstimate];
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return array.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil){
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    //cell.backgroundColor = [UIColor colorWithHue:0.61 saturation:0.09 brightness:0.99 alpha:1.0];
    cell.textLabel.text = [NSString stringWithFormat:@"%@",array[indexPath.row]];
    return cell;
}



- (void)Right_swipe_set{
    
    UISwipeGestureRecognizer* swipeRightGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(selSwipeRightGesture:)];
    
    // 右スワイプのイベントを指定します。
    swipeRightGesture.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipeRightGesture];



}

- (void)Left_swipe_set{
    
    UISwipeGestureRecognizer* swipeLeftGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(selSwipeLeftGesture:)];
    
    // 右スワイプのイベントを指定します。
    swipeLeftGesture.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipeLeftGesture];
    
    
    
}


- (void)Up_swipe_set{
    
    UISwipeGestureRecognizer* swipeUpGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(selSwipeUpGesture:)];
    
    // 右スワイプのイベントを指定します。
    swipeUpGesture.direction = UISwipeGestureRecognizerDirectionUp;
    [self.view addGestureRecognizer:swipeUpGesture];
    
}

- (void)Down_swipe_set{
    
    UISwipeGestureRecognizer* swipeDownGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(selSwipeDownGesture:)];
    
    // 右スワイプのイベントを指定します。
    swipeDownGesture.direction = UISwipeGestureRecognizerDirectionDown;
    [self.view addGestureRecognizer:swipeDownGesture];
    
}

// 右スワイプされた時に実行されるメソッド、selectorで指定します。
- (void)selSwipeRightGesture:(UISwipeGestureRecognizer *)sender {
    // 右スワイプされた時にログに表示
    
    remenber_position = (int)Line_View.frame.origin.x;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];
    switch (remenber_position) {
        case 100://真ん中にある時
            Line_View.frame = CGRectMake(250, Line_View.frame.origin.y-55, 50, 50);
            Facebook_View.frame = CGRectMake(100, Facebook_View.frame.origin.y+55, 120, 120);
            Phones_View.frame = CGRectMake(20, Phones_View.frame.origin.y, 50, 50);

            break;
        case 250://右にある時
            Line_View.frame = CGRectMake(20, Line_View.frame.origin.y, 50, 50);
            Facebook_View.frame = CGRectMake(250, Facebook_View.frame.origin.y-55, 50, 50);
            Phones_View.frame = CGRectMake(100, Phones_View.frame.origin.y+55, 120, 120);
            
            break;
        case 20://左にある時
            Line_View.frame = CGRectMake(100, Line_View.frame.origin.y+55, 120, 120);
            Facebook_View.frame = CGRectMake(20, Facebook_View.frame.origin.y, 50, 50);
            Phones_View.frame = CGRectMake(250, Phones_View.frame.origin.y-55, 50, 50);
            //[self.view bringSubviewToFront:_Middle_view];
            
            break;
            
        default:
            break;
    }
    [UIView commitAnimations];
    
    [self positionEstimate];
    remenber_position = (int)Line_View.frame.origin.x;
    
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setInteger:remenber_position forKey:@"remember"];
    [userDefaults synchronize];
    
    [userDefaults setObject: Phones forKey:@"Phones"];
    [userDefaults synchronize];
    
    [userDefaults setObject:FacebookID forKey:@"Facebook"];
    [userDefaults synchronize];
    
}


// 右スワイプされた時に実行されるメソッド、selectorで指定します。
- (void)selSwipeLeftGesture:(UISwipeGestureRecognizer *)sender {
    // 右スワイプされた時にログに表示

    remenber_position = (int)Line_View.frame.origin.x;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];
    switch (remenber_position) {
        case 100://真ん中にある時
            Line_View.frame = CGRectMake(20, Line_View.frame.origin.y-55, 50, 50);
            Facebook_View.frame = CGRectMake(250, Facebook_View.frame.origin.y, 50, 50);
            Phones_View.frame = CGRectMake(100, Phones_View.frame.origin.y+55, 120, 120);
            break;
            
        case 20://左にある時
            Line_View.frame = CGRectMake(250, Line_View.frame.origin.y, 50, 50);
            Facebook_View.frame = CGRectMake(100, Facebook_View.frame.origin.y+55, 120, 120);
            Phones_View.frame = CGRectMake(20, Phones_View.frame.origin.y-55, 50, 50);
            break;
            
        case 250://右にある時
            Line_View.frame = CGRectMake(100, Line_View.frame.origin.y+55, 120, 120);
            Facebook_View.frame = CGRectMake(20, Facebook_View.frame.origin.y-55, 50, 50);
            Phones_View.frame = CGRectMake(250, Phones_View.frame.origin.y, 50, 50);
            break;
            
        default:
            break;
    }
    [UIView commitAnimations];
    remenber_position = (int)Line_View.frame.origin.x;
    [self positionEstimate];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setInteger:remenber_position forKey:@"remember"];
    [userDefaults synchronize];
    
    [userDefaults setObject: Phones forKey:@"Phones"];
    [userDefaults synchronize];
    
    [userDefaults setObject:FacebookID forKey:@"Facebook"];
    [userDefaults synchronize];
    
}


// 上スワイプされた時に実行されるメソッド、selectorで指定します。
- (void)selSwipeUpGesture:(UISwipeGestureRecognizer *)sender {
    // 上スワイプされた時にログに表示
    
    
    if(![self.serNameField.text isEqualToString:@""]){
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.2];
        switch ((int)Line_View.frame.origin.x) {
            case 100://真ん中にある時
                Line_View.frame = CGRectMake(100, 0,120,10);
                break;
            case 20://左にある時
                Phones_View.frame = CGRectMake(100, 0,120,10);
                break;
            case 250://右にある時
                Facebook_View.frame = CGRectMake(100, 0,120,10);
                break;
            default:
                break;
        }
    
        // デリゲートを設定する
        [UIView setAnimationDelegate:self];
  
        // アニメーション終了後に呼び出されるメソッドを指定する
        [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
    
        [UIView commitAnimations];
    }else{
        
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:NSLocalizedString(@"BePost ID is empty.", nil)
                              message:NSLocalizedString(@"Please put BePostID", nil)
                              delegate:self
                              cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
    }
    
}

//下スワイプ後に呼び出されるメソッド
- (void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
    
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setInteger:remenber_position forKey:@"remember"];
    [userDefaults synchronize];
    
    
    [self performSegueWithIdentifier:@"sender" sender:self];
    
}

// 下スワイプされた時に実行されるメソッド、selectorで指定します。
- (void)selSwipeDownGesture:(UISwipeGestureRecognizer *)sender {
    // 下スワイプされた時にログに表示
    
    [self performSegueWithIdentifier:@"reciever" sender:self];
    
}

- (void)positionEstimate{
    
    
    /*
     UIImage* image = [UIImage imageNamed:@"Line.png"];
     LineImage = [[UIImageView alloc] initWithImage:image];
     [LineImage setContentMode:UIViewContentModeScaleAspectFit];
     LineImage.frame = CGRectMake(0, 0, 120, 120);
     [Line_View addSubview:LineImage];
     
     image = [UIImage imageNamed:@"Facebook.png"];
     FacebookImage = [[UIImageView alloc] initWithImage:image];
     [FacebookImage setContentMode:UIViewContentModeScaleAspectFit];
     FacebookImage.frame = CGRectMake(20, 20, 80, 80);
     [Facebook_View addSubview:FacebookImage];
     
     image = [UIImage imageNamed:@"Address.png"];
     PhonesImage = [[UIImageView alloc] initWithImage:image];
     [PhonesImage setContentMode:UIViewContentModeScaleAspectFit];
     PhonesImage.frame = CGRectMake(10, 10, 100, 100);
     [Phones_View addSubview:PhonesImage];
     
     */
    


    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];
    switch ((int)Line_View.frame.origin.x) {
        case 100://真ん中にある時
            self.idNameLabel.text = NSLocalizedString(@"Line", nil);
            self.NameBox.text = Line;
            self.PickerBtn.alpha = 0;
            CurrentNum = 0;
            loginview.alpha = 0;
            self.NameBox.enabled = YES;

            LineImage.frame = CGRectMake(0, 0, 120, 120);
            FacebookImage.frame = CGRectMake(8, 8, 34, 34);
            PhonesImage.frame = CGRectMake(4, 4, 42, 42);
            self.NameBox.alpha = 1;
            self.FBBtn.alpha = 0;
            break;
        case 20://左にある時
            self.idNameLabel.text = NSLocalizedString(@"Phone", nil);
            self.NameBox.text = Phones;
            self.PickerBtn.alpha = 1;
            CurrentNum = 2;
            //self.PickerBtn.frame = CGRectMake(self.PickerBtn.frame.origin.x, self.PickerBtn.frame.origin.y, 218, self.PickerBtn.frame.size.height);
            //self.PickerBtn.titleLabel.text = NSLocalizedString(@"検索", nil);
            loginview.alpha = 0;
            self.NameBox.enabled = YES;
            
            LineImage.frame = CGRectMake(0, 0, 50, 50);
            FacebookImage.frame = CGRectMake(8, 8, 34, 34);
            PhonesImage.frame = CGRectMake(10, 10, 100, 100);
            self.NameBox.alpha = 1;
            self.FBBtn.alpha = 0;

            break;
        case 250://右にある時
            self.idNameLabel.text = NSLocalizedString(@"Facebook", nil);
            self.NameBox.text = FacebookID;
            self.PickerBtn.alpha = 0;
            CurrentNum = 1;
            loginview.alpha = 0.7;
            self.NameBox.enabled = NO;
            self.FBBtn.alpha = 1;
            
            LineImage.frame = CGRectMake(0, 0, 50, 50);
            FacebookImage.frame = CGRectMake(20, 20, 80, 80);
            PhonesImage.frame = CGRectMake(4, 4, 42, 42);
            
            
            break;
        default:
            break;
    }
    [UIView commitAnimations];

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)menuTap:(id)sender {
    
    /*
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];
    if(MenuFlag==YES){
    self.menuView.frame = CGRectMake(0, 40, 320, 420);
    self.menuView.alpha = 1.0;
        MenuFlag = NO;
    }else{
        self.menuView.frame = CGRectMake(320, 60, 0, 0);
        self.menuView.alpha = 0.0;
        MenuFlag = YES;
    }
    [UIView commitAnimations];
     */
}

- (IBAction)NameEdit:(id)sender {
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    switch ((int)Line_View.frame.origin.x) {
        case 100://真ん中にある時
            Line = self.NameBox.text;
            [userDefaults setObject:self.NameBox.text forKey:@"Line"];
            break;
        case 20://左にある時
            Phones = self.NameBox.text;
            [userDefaults setObject:self.NameBox.text forKey:@"Phones"];
            break;
        case 250://右にある時
            [userDefaults setObject:self.NameBox.text forKey:@"Facebook"];
            break;
        default:
            break;
    }
    
     self.IDView.frame = CGRectMake(self.IDView.frame.origin.x, self.IDView.frame.origin.y+200, self.IDView.frame.size.width, self.IDView.frame.size.height);
    
    // 値をすぐに反映させる
    [userDefaults synchronize];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
        if([[segue identifier] isEqualToString:@"sender"]){
        
        SenderViewController *dvc = (SenderViewController*)segue.destinationViewController;
        dvc.sendDataName = self.idNameLabel.text;
            
            if( [self.idNameLabel.text isEqualToString:@"Facebook"] ){
                dvc.Name = FacebookID;
            }else{
                dvc.Name = self.NameBox.text;
            }
                dvc.UserName = userName;

        }else if([[segue identifier] isEqualToString:@"reciever"]){
        
            RecieverViewController *dvc = (RecieverViewController*)segue.destinationViewController;
            dvc.Name = self.NameBox.text;
        
        }
    
 
}

//連絡帳アクセス

- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    //[self dismissModalViewControllerAnimated:YES];
    
}


- (IBAction)showPicker:(id)sender
{
    ABPeoplePickerNavigationController *picker;
    switch ((int)Line_View.frame.origin.x) {
        case 100://ライン
            break;
        case 20://Phones
            picker = [[ABPeoplePickerNavigationController alloc] init];
            picker.peoplePickerDelegate = self;
            //[self presentModalViewController:picker animated:YES];
            [self presentViewController:picker animated:YES completion:nil];
            break;
        case 250://Facebooks
            [self FacebookOpen];
            break;
        default:
            break;
    }
    
/* Phones
    ABPeoplePickerNavigationController *picker =
    [[ABPeoplePickerNavigationController alloc] init];
    picker.peoplePickerDelegate = self;
    //[self presentModalViewController:picker animated:YES];
    [self presentViewController:picker animated:YES completion:nil];
*/
    
}

- (void)FacebookOpen{
    
    //self.PickerBtn.titleLabel.text = @"ID取得";

}


- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person{
    
    [self displayPerson:person];
    //[self dismissModalViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
    return NO;
    
}

- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier{
    
    return NO;
    
}


- (void)displayPerson:(ABRecordRef)person
{
   // NSString* name = (__bridge_transfer NSString*)ABRecordCopyValue(person,kABPersonFirstNameProperty);
    //self.firstName.text = name;
    NSString* phone = nil;
    ABMultiValueRef phoneNumbers = ABRecordCopyValue(person,
                                                     kABPersonPhoneProperty);
    if (ABMultiValueGetCount(phoneNumbers) > 0) {
        phone = (__bridge_transfer NSString*)
        ABMultiValueCopyValueAtIndex(phoneNumbers, 0);
    } else {
        phone = @"[None]";
    }
    Phones = phone;
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:Phones forKey:@"Phones"];
    [userDefaults synchronize];
    
    NSLog(@"%@",phone);
    
}

- (IBAction)test:(id)sender {
    
    if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusNotDetermined) { // 未設定
        ABAddressBookRef book;
        ABAddressBookRequestAccessWithCompletion(book, ^(bool granted, CFErrorRef error) {
            
        });
    } else if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusRestricted ||
               ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusDenied) { // 拒否
        UIAlertView *alert =
        [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Notice",nil) message:NSLocalizedString(@"Please turn ON BlueTooth And turn OFF Airpane Mode.",nil)
                                  delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        return;
    } else if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusAuthorized) { // 許可
        
        /*
        ABNewPersonViewController *view = [[ABNewPersonViewController alloc] init];
        view.newPersonViewDelegate = self;
        
        UINavigationController *newNavigationController = [[UINavigationController alloc]
                                                           initWithRootViewController:view];
         [self presentViewController:newNavigationController animated:YES completion: nil];
        */
        
        ABRecordRef person = ABPersonCreate();
        CFErrorRef error = NULL;
        
        // 名前
        //ABRecordSetValue(person, kABPersonFirstNameProperty, @"Mr.T", NULL);
        
        // 電話番号
        ABMutableMultiValueRef phone =
        ABMultiValueCreateMutable(kABMultiStringPropertyType);
        ABMultiValueAddValueAndLabel(phone,(__bridge CFTypeRef)(Phones), kABPersonPhoneMainLabel, NULL);
        ABRecordSetValue(person,
                         kABPersonPhoneProperty, phone, &error);
        CFRelease(phone);
        
        // メアド
        /*
        ABMutableMultiValueRef email =
        ABMultiValueCreateMutable(kABMultiStringPropertyType);
        ABMultiValueAddValueAndLabel(email,
                                     @"test@sample.com", CFSTR("email"), NULL);
        ABRecordSetValue(person, 
                         kABPersonEmailProperty, email, &error);
        CFRelease(email); 
        */
        
        ABUnknownPersonViewController *view = [[ABUnknownPersonViewController alloc] init];
        view.unknownPersonViewDelegate = self; view.displayedPerson = person;         [self.navigationController pushViewController:view animated:YES];
        
    }
    
}

- (IBAction)test2:(id)sender {
    
    NSString *urlString = @"http://www.google.co.jp";
    NSURL *url = [NSURL URLWithString:urlString];
    
    // ブラウザを起動する
    [[UIApplication sharedApplication] openURL:url];
    
}


- (void)unknownPersonViewController:(ABUnknownPersonViewController *)unknownCardViewController didResolveToPerson:(ABRecordRef)person{


}

-(BOOL)textFieldShouldBeginEditing:
(UITextField*)textField{
    
    if(textField.tag == 10){
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];
    
    self.IDView.frame = CGRectMake(self.IDView.frame.origin.x, self.IDView.frame.origin.y-200, self.IDView.frame.size.width, self.IDView.frame.size.height);
    [UIView commitAnimations];
    return YES;
    }
    return YES;
}

- (IBAction)FacebookBtn:(id)sender {
    
    ACAccountStore *accountStore = [[ACAccountStore alloc]init];
    ACAccountType *accountType = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierFacebook];
    NSMutableDictionary *options = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"1431330840463802",ACFacebookAppIdKey,[NSArray arrayWithObjects:@"email",nil],ACFacebookPermissionsKey,ACFacebookAudienceOnlyMe,ACFacebookAudienceKey,nil];
    
    UIActivityIndicatorView *indicator;
    indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    indicator.color = [UIColor redColor];
    indicator.frame = CGRectMake(110, 200, 100, 100);
    // サブビューに追加する
    [self.view addSubview:indicator];
    
    FacebookID = @"";
    
    NSArray *accounts = [accountStore accountsWithAccountType:accountType];
    
    if(accounts.count != 0){
        ACAccount *anAccount = [accounts lastObject];
        NSString *uid = [[[anAccount valueForKey:@"properties"] objectForKey:@"uid"] stringValue];
        NSLog(@"%@",uid);
        FacebookID = [NSString stringWithFormat:@"%@",uid];
        NSLog(@"face%@",FacebookID);
        self.NameBox.text = FacebookID;
        NSLog(@"a = %@",FacebookID);
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:FacebookID forKey:@"Facebook"];
        [userDefaults synchronize];
    }else{
        // クルクルと回し始める
        [indicator startAnimating];
    [accountStore requestAccessToAccountsWithType:accountType options:options completion:^(BOOL granted, NSError *error) {
        
        if(granted){
            
            NSArray *accounts = [accountStore accountsWithAccountType:accountType];
            ACAccount *anAccount = [accounts lastObject];
            NSString *uid = [[[anAccount valueForKey:@"properties"] objectForKey:@"uid"] stringValue];
            NSLog(@"%@",uid);
            FacebookID = [NSString stringWithFormat:@"%@",uid];
            NSLog(@"face%@",FacebookID);
            self.NameBox.text = FacebookID;
            NSLog(@"a = %@",FacebookID);
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults setObject:FacebookID forKey:@"Facebook"];
            [userDefaults synchronize];
            UIAlertView *alert =
            [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Complete",nil) message:NSLocalizedString(@"Success.",nil)
                                      delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [indicator stopAnimating];
        }else{
            
            UIAlertView *alert =
            [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Notice",nil) message:NSLocalizedString(@"You don't have FacebookID in your iPhone. Please download Facebook app from app store and regist your FacebookID. Otherwise, please access setting>>Facebook and allow Bepost to use your account.",nil)
                                      delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [indicator stopAnimating];
        }
    }];
    }
    

    
    /*
    if(FacebookID == nil){
        
        UIAlertView *alert =
        [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Notice",nil) message:NSLocalizedString(@"You don't have FacebookID in your iPhone. Please download Facebook app from app store and regist your FacebookID. Otherwise, please access setting>>Facebook and allow Bepost to use your account.",nil)
                                  delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    
    }
    */
    

}

- (IBAction)editEnd:(id)sender {
    

    
}

- (BOOL)textField:(UITextField *)textField
shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    if(textField.tag == 11){
    // すでに入力されているテキストを取得
    NSMutableString *text = [textField.text mutableCopy];
    
    // すでに入力されているテキストに今回編集されたテキストをマージ
    [text replaceCharactersInRange:range withString:string];
    
    // 結果が文字数をオーバーしていないならYES，オーバーしている場合はNO
    return ([text length] <= 6);
    }
    return YES;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    if (textField.tag == 11) {
        
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:textField.text forKey:@"userName"];
        [userDefaults synchronize];
        userName = textField.text;
        [self.view endEditing:YES];
        return YES;
        
    }
    return YES;

}


@end
