//
//  ViewController.m
//  Example-ObjC-MGBS
//
//  Created by Guillermo Garcia Rebolo on 24/1/17.
//  Copyright © 2017 Guillermo Garcia Rebolo. All rights reserved.
//

#import "ViewController.h"
@import MGBottonSheet

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *bottomSheetButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.bottomSheetButton addTarget:self action:@selector(showBottomSheet) forControlEvents:UIControlEventTouchUpInside];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)showBottomSheet {
    [self presentViewController:[self constructBottomSheet] animated:YES completion:nil];
}

- (MGBottomSheet *)constructBottomSheet {
    MGBottomSheet *mgBottomSheet = [MGBottomSheet mgBottomSheetWithTitle:@"Actions"];
    
    ActionSheet *deleteAction = [ActionSheet actionWithTitle:@"Delete" imageIcon:[UIImage imageNamed:@"FavouriteFilled"] completion:^{
        NSLog(@"CallBack");
    }];
    
    ActionSheet *saveAction =[ActionSheet actionWithTitle:@"Save" imageIcon:[UIImage imageNamed:@"FavouriteFilled"] completion:^{
        NSLog(@"CallBack");
    }];
    
    ActionSheet *markAction = [ActionSheet actionWithTitle:@"Mark" imageIcon:[UIImage imageNamed:@"FavouriteFilled"] completion:^{
        NSLog(@"CallBack");
    }];
    
    [saveAction setActionDisabled];
    
    [mgBottomSheet addAction:deleteAction];
    [mgBottomSheet addAction:saveAction];
    [mgBottomSheet addAction:markAction];
    
    return mgBottomSheet;
}


@end
