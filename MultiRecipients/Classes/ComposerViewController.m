#import "ComposerViewController.h"


@implementation ComposerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
    _fields = [[NSArray alloc] initWithObjects:
               [[[TTMessageRecipientField alloc] initWithTitle: TTLocalizedString(@"To:", @"")
                                                      required: YES] autorelease],
               [[[TTMessageRecipientField alloc] initWithTitle: TTLocalizedString(@"CC:", @"")
                                                      required: NO] autorelease],
               [[[TTMessageSubjectField alloc] initWithTitle: TTLocalizedString(@"Subject:", @"")
                                                    required: NO] autorelease],
               nil];    
  }
  
  return self;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
  if ([textField isKindOfClass:[TTPickerTextField class]]) {
    NSLog(@"is picker");
      for (int i = 0; i < _fields.count; ++i) {
        id field = [_fieldViews objectAtIndex:i];
        if (field == textField) {
          switch (i) {
            case 0: {
              id ccField = [_fieldViews objectAtIndex:1];
              [textField setDataSource:[self dataSource]];
              [ccField setDataSource:nil];
              NSLog(@"to");
              break;
            }
            case 1: {
              id toField = [_fieldViews objectAtIndex:0];
              [textField setDataSource:[self dataSource]];
              [toField setDataSource:nil];
              NSLog(@"cc");
              break;
            }
            default:
              break;
          }
        }
      }
      // what is it's index
  }
  return YES;
}
@end
