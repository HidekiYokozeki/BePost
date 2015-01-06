//
//  ViewController.h
//  AddTest
//
//  Created by 横関秀樹 on 2014/04/29.
//  Copyright (c) 2014年 Hideki yokozeki. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import <FacebookSDK/FacebookSDK.h>

@interface ViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, ABPeoplePickerNavigationControllerDelegate,ABUnknownPersonViewControllerDelegate, FBLoginViewDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIButton *menuSelect;
- (IBAction)menuTap:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *sendDam;
@property (weak, nonatomic) IBOutlet UIButton *RecDam;
@property (weak, nonatomic) IBOutlet UILabel *idNameLabel;
@property (weak, nonatomic) IBOutlet UITextField *NameBox;
- (IBAction)NameEdit:(id)sender;
- (IBAction)showPicker:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *PickerBtn;
- (IBAction)test:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *PutTextView;
@property (weak, nonatomic) IBOutlet UIView *IDView;
- (IBAction)FacebookBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *FBBtn;
@property (weak, nonatomic) IBOutlet UITextField *serNameField;
- (IBAction)editEnd:(id)sender;


@end
