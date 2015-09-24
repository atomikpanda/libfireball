#import "libfireball.h"
#import "libfireball_private.h"

void FBSetPrefsTint(UIViewController *prefs, UIColor *tintColor)
{
	UIViewController *self = prefs;

	UISplitViewController *splitViewController = (UISplitViewController *)self.splitViewController;//[[UIApplication sharedApplication] keyWindow].rootViewController;
	UINavigationController *navigationController = [splitViewController.viewControllers lastObject];
	UIViewController *lastViewController = navigationController.visibleViewController;//

	[navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:tintColor}];

	navigationController.navigationBar.tintColor = tintColor;
	lastViewController.view.tintColor = tintColor;
	[lastViewController.view setAutoresizesSubviews:YES];
	if([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
		[self setEdgesForExtendedLayout:UIRectEdgeBottom];
	}

	[UISegmentedControl appearanceWhenContainedIn:self.class, nil].tintColor = tintColor;
	[UISlider appearanceWhenContainedIn:self.class, nil].maximumTrackTintColor = tintColor;

	[[UISwitch appearanceWhenContainedIn:self.class, nil] setOnTintColor:tintColor];
}

void FBResetPrefsTint(UIViewController *prefs)
{
	UIViewController *self = prefs;

	UISplitViewController *splitViewController = (UISplitViewController *)self.splitViewController;//[[UIApplication sharedApplication] keyWindow].rootViewController;
	UINavigationController *navigationController = [splitViewController.viewControllers lastObject];
	UIViewController *lastViewController = navigationController.visibleViewController;//

	navigationController.navigationBar.barTintColor = nil;
	navigationController.navigationBar.tintColor = nil;
	[navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor blackColor]}];
	lastViewController.view.tintColor = nil;
	[lastViewController.view setAutoresizesSubviews:NO];
}

PSSpecifier *FBVersionCopyrightSpecifier(NSString *packageIdentifier, NSString *copyrightName, NSString *yearMade)
{
	NSTask *task = [[NSTask alloc] init];
	[task setLaunchPath: @"/bin/sh"];
	[task setArguments:
	 @[@"-c", [NSString stringWithFormat:@"dpkg -s %@ | grep 'Version'", packageIdentifier]]
	];
	NSPipe *pipe = [NSPipe pipe];
	[task setStandardOutput:pipe];
	[task launch];

	NSData *data = [[[task standardOutput] fileHandleForReading] readDataToEndOfFile];
	NSString *version = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];


	[task release];

	PSSpecifier *footer = [FBGetClass(@"PSSpecifier") preferenceSpecifierNamed:@"" target:nil set:nil get:nil detail:nil cell:PSGroupCell edit:nil];
	[footer setProperty:[NSString stringWithFormat:@"© %@ %@\n %@", copyrightName, FBDynamicYear(yearMade), version] forKey:@"footerText"];
	[footer setProperty:@"1" forKey:@"footerAlignment"];

	[version release];

	return footer;
}

static NSString *FBDynamicYear(NSString *yearMade)
{
	NSString *dynamicYear = @"";
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"]];
	[dateFormatter setDateFormat:@"yyyy"];
	[dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
	NSDate *date = [NSDate date];
	NSString *dateString = [dateFormatter stringFromDate:date];
	if ([yearMade isEqual:dateString]) dynamicYear = dateString;
	else dynamicYear = [NSString stringWithFormat:@"%@ - %@", yearMade, dateString];
	[dateFormatter release];
	return dynamicYear;
}

void FBKillProcess(NSString *signal, NSString *processName)
{
	pid_t pid;
	signal = signal ? signal : @"9";
	signal = [NSString stringWithFormat:@"-%@", signal];

	const char *args[] = {"killall", signal.UTF8String, processName.UTF8String, NULL};
	posix_spawn(&pid, "/usr/bin/killall", NULL, NULL, (char *const *)args, NULL);
}

@interface FBTwitterShareHandler : NSObject
@property (nonatomic, retain) NSString *shareText;
@property (assign) UIViewController *container;
@end

@implementation FBTwitterShareHandler
@synthesize shareText, container;

- (void)shareTapped:(UIBarButtonItem *)sender
{
	SLComposeViewController *composeController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
	[composeController setInitialText:shareText];
	[self.container presentViewController:composeController animated:YES completion:nil];
}

- (void)dealloc
{
	self.shareText = nil;
	[super dealloc];
}

@end

void FBAddTwitterShareButton(UIViewController *prefs, UIImage *twitterIcon, NSString *shareText)
{
	FBTwitterShareHandler *shareHandler = [[FBTwitterShareHandler new] autorelease];
	shareHandler.container = prefs;
	shareHandler.shareText = shareText;

	UIBarButtonItem *tweet = [[UIBarButtonItem alloc] initWithImage:twitterIcon style:UIBarButtonItemStylePlain target:shareHandler action:@selector(shareTapped:)];
	UIGraphicsBeginImageContextWithOptions(CGSizeMake(20, 20), NO, 0.0);
	UIImage *blank = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	[tweet setBackgroundImage:blank forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
	[prefs.navigationItem setRightBarButtonItem:tweet];

	[tweet release];
}

void FBOpenTwitterUsername(NSString *username)
{
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:[@"http://twitter.com/" stringByAppendingString:username]]];
}

void FBOpenMailAddress(NSString *email)
{
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:[@"mailto:" stringByAppendingString:email]]];
}
