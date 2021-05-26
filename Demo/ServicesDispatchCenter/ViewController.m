//
//  ViewController.m
//  ServicesDispatchCenter
//
//  Created by Bc.whi1te_Lei on 2018/9/21.
//  Copyright © 2018 Bc.whi1te_Lei. All rights reserved.
//

#import "ViewController.h"
#import "SDGPostMan+Test.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   NSDictionary *dict =  [[SDGPostMan sharedInstance]SDGPostMan_Test_GetDictionary:@{@"123":@"456"}];
    NSLog(@"dict %@",dict);
    
    [[SDGPostMan sharedInstance]SDGPostMan_Test_InvokeBlock:^(NSString * _Nonnull code) {
        NSLog(@"code%@",code);
    }];
    
    
    UIViewController *vc = [[SDGPostMan sharedInstance] SDGPostMan_Test_GetController:nil];
    NSLog(@"%@",vc.view.backgroundColor);
        
    // Do any additional setup after loading the view, typically from a nib.
}

@end
