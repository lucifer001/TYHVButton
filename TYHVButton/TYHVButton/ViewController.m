//
//  ViewController.m
//  TYHVButton
//
//  Created by PEND_Q on 2020/4/20.
//  Copyright © 2020 轻舔指尖. All rights reserved.
//

#import "ViewController.h"
#import "TYHVButton.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIView *tabbarView;
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (strong, nonatomic) IBOutletCollection(TYHVButton) NSArray *itemBtnAry;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)clickItemBtn:(UIButton *)sender
{
    for (UIButton *item in self.itemBtnAry) {
        item.selected = sender.tag == item.tag;
    }
}

@end
