//
//  ViewController.m
//  MeetMeUp
//
//  Created by MIKE LAND on 10/13/14.
//  Copyright (c) 2014 MIKE LAND. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSArray *groupOfMeetups;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    NSURL *url = [NSURL URLWithString:@"https://api.meetup.com/2/open_events.json?zip=60604&text=mobile&time=,1w&key=477d1928246a4e162252547b766d3c6d"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//        NSLog(@"%@", jsonString);
//        NSLog(@"%@", connectionError);
        NSError *jsonError;
        NSDictionary *dictionaryMeetups = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        self.groupOfMeetups = [dictionaryMeetups objectForKey:@"results"];
        [self.tableView reloadData];
//        NSLog(@"%@", self.groupOfMeetups);
    }];
//    NSLog(@"go time");
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *groupOfMeetupsVar = [self.groupOfMeetups objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyCellID"];



    cell.textLabel.text = [groupOfMeetupsVar objectForKey:@"name"];
    cell.detailTextLabel.text = [[groupOfMeetupsVar objectForKey:@"venue"] objectForKey:@"name"];

    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.groupOfMeetups.count;
}


@end
