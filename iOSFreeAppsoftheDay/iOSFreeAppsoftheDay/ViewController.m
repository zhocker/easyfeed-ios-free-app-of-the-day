//
//  ViewController.m
//  iOSFreeAppsoftheDay
//
//  Created by Tanawat Polsuwan on 8/16/56 BE.
//  Copyright (c) 2556 Tanawat Polsuwan. All rights reserved.
//

#import "ViewController.h"
#import "Entrie.h"
#import "EntrieCell.h"
@interface ViewController () <UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *_entrieTableView;
- (IBAction)infoButtonAction:(id)sender;

@end

@implementation ViewController {
    NSArray *_entries;
    NSUInteger userSelectedIndex;
    UIActivityIndicatorView *spinner;
}
static NSUInteger OPENONSAFARI = 1;

BOOL isLog = YES;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self progress];
    [self loadFeedData];

}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

}


-(void)progress{
    spinner = [[UIActivityIndicatorView alloc]
               initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    spinner.center = CGPointMake((self.view.frame.size.width/2), (self.view.frame.size.width/2));
    spinner.hidesWhenStopped = YES;
    [self.view addSubview:spinner];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadFeedData {
    [spinner startAnimating];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        
        NSURL *url = [NSURL URLWithString:@"https://www.facebook.com/feeds/page.php?format=rss20&id=%20153667784836819&format=json"];
        NSData *data = [NSData dataWithContentsOfURL:url];
        NSError *error;
        NSMutableDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data
                                                                    options:kNilOptions
                                                                      error:&error];

        if (error != nil) {
            if (isLog) NSLog(@"error:%@",error);
            return;
        }
        
        
        
        NSArray *jsonArray = [NSArray arrayWithArray:[JSON objectForKey:@"entries"]];
        if (isLog) NSLog(@"%@",jsonArray);
        NSMutableArray *entriesTemp = [NSMutableArray arrayWithCapacity:[jsonArray count]];
        for (NSDictionary *dict in jsonArray) {
            [entriesTemp addObject:[[Entrie alloc] initWithDictionany:dict]];
        }
        _entries = [[NSArray alloc] initWithArray:entriesTemp];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (isLog) NSLog(@"%@",_entries);
            [self._entrieTableView reloadData];
            [spinner stopAnimating];
        });
    });
    
}

-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 350;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_entries count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    EntrieCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EntrieCell"];
    [cell configureWithPhoto:_entries[indexPath.row]];
    return cell;

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    userSelectedIndex = indexPath.row;
    [self openAlertView];
}

-(void)openAlertView {
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"ฟรีกาก" message:@"Open on Safari" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Open", nil];
    [alertView show];
}

-(void)linkButtonClick:(Entrie *)entrie{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[entrie alternate]]];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == OPENONSAFARI) {
        [self linkButtonClick:_entries[userSelectedIndex]];
    }
}



- (IBAction)infoButtonAction:(id)sender {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"ฟรีกาก" message:@"เขี่ย by Editor #CoEToday" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alertView show];
}
@end
