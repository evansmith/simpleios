#import "CakeTableViewController.h"

@interface CakeTableViewController ()

@end

@implementation CakeTableViewController
{
    NSMutableArray *cakeList;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if(cakeList == nil)
    {
        cakeList = [[NSMutableArray alloc] init];
    }
    else
    {
        [cakeList removeAllObjects];
    }
    
    // todo Customize this url
    NSURL *URL = [NSURL URLWithString:@"http://quiet-ravine-1936.herokuapp.com/cakes.json"];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               NSError *jsonParseError;
                               NSArray *cakeData = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&jsonParseError];
                               NSLog(@"%@", cakeData);
                               
                               
                               // todo process the cake data here
                               for(int i = 0; i < [cakeData count]; i++){
                                   cakeList[i] = cakeData[i];
                               }
                               
                               
                               
                               [self.tableView reloadData];
                               
                           }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return cakeList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CakeListCell" forIndexPath:indexPath];
    
    cell.textLabel.text = cakeList[indexPath.row];
    
    return cell;
}

@end
