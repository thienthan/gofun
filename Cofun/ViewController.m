//
//  ViewController.m
//  Cofun
//
//  Created by APPLE TINPHAT on 9/24/15.
//  Copyright © 2015 TVT25. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UILabel *lbUserNameUser;
@property (strong, nonatomic) IBOutlet UILabel *lbEmailUser;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Log out" style:UIBarButtonItemStylePlain target:self action:@selector(logoutUser:)];
    
    NSString *EmailUser    = [[NSUserDefaults standardUserDefaults]
                              stringForKey:@"preferenceEmailUser"];
    NSString *NameUser     = [[NSUserDefaults standardUserDefaults]
                              stringForKey:@"preferenceNameUser"];
    _lbUserNameUser.text = [NSString stringWithFormat:@"Wellcome to Gofun. Wish a happy day %@",NameUser];
    _lbEmailUser.text = [NSString stringWithFormat:@"Email --  %@",EmailUser];

    // Do any additional setup after loading the view, typically from a nib.
}

- (void)logoutUser:(id)sender{
    [self dismissViewControllerAnimated:YES completion:^{
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"preferenceEmailUser"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"preferencePassWordUser"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"preferenceNameUser"];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
