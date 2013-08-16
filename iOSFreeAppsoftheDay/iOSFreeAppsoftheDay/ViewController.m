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
@interface ViewController () <UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *_entrieTableView;

@end

@implementation ViewController {
    NSArray *_entries;
}

BOOL isLog = YES;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self loadFeedData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadFeedData {
    
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
        });
    });
    
}

-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 308;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_entries count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    EntrieCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EntrieCell"];
    [cell configureWithPhoto:_entries[indexPath.row]];
    return cell;

}


@end
