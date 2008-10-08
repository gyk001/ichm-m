//
//  RootViewController.m
//  iChm
//
//  Created by Robin Lu on 10/7/08.
//  Copyright __MyCompanyName__ 2008. All rights reserved.
//

#import "RootViewController.h"
#import "iChmAppDelegate.h"
#import "CHMDocument.h"
#import "TableOfContentController.h"
#import "CHMBrowserController.h"

@interface RootViewController (Private)

- (void)setupFileList;

@end

@implementation RootViewController

#pragma mark init
- (void)awakeFromNib
{
	self.title = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"];
	[self setupFileList];
	NSLog(@"init file list");
	
}

- (void)setupFileList
{
	fileList = [[NSMutableArray alloc] init];
	NSString* docDir = [NSString stringWithFormat:@"%@/Documents", NSHomeDirectory()];
	NSDirectoryEnumerator *direnum = [[NSFileManager defaultManager]
									  enumeratorAtPath:docDir];
	NSString *pname;
	while (pname = [direnum nextObject])
	{
		if ([[pname pathExtension] isEqualToString:@"chm"])
		{
			[fileList addObject:pname];
		}
	}
}

#pragma mark tableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1 ;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [fileList count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"fileListCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Set up the cell
	cell.text = [fileList objectAtIndex:indexPath.row];
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic -- create and push a new view controller
	NSString* filename = [fileList objectAtIndex:indexPath.row];
	CHMDocument *doc = [[CHMDocument alloc] initWithFileName:filename];
	//TableOfContentController *tocController = [[TableOfContentController alloc] initWithCHMDocument:doc];
	//[[self navigationController] pushViewController:tocController animated:YES];
	//[tocController release];
	CHMBrowserController *browserController = [[CHMBrowserController alloc] initWithCHMDocument:doc];
	[[self navigationController] pushViewController:browserController animated:YES];
	[browserController loadPath:[doc homePath]];
	[browserController release];
	[doc release];
}


/*
- (void)viewDidLoad {
    [super viewDidLoad];
    // Uncomment the following line to add the Edit button to the navigation bar.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
*/


/*
// Override to support editing the list
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
    }   
    if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/


/*
// Override to support conditional editing of the list
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support rearranging the list
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the list
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
}
*/

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}


- (void)dealloc {
	[fileList release];
    [super dealloc];
}


@end
