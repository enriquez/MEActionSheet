# MEActionSheet

`UIActionSheet` subclass with a simpler API using blocks and target/action invocations.

## Add to your project

You can either copy the files into your project or you can use CocoaPods with the following in your Podfie:

    pod 'MEActionSheet', '~> 1.0.0'

## Examples

Below are two examples of an action sheet that displays a cancel button, destructive button, and two other buttons. The first is how you would normally create an action sheet with `UIActionSheet`. The second is the equivalent, but using `MEActionSheet`.

Using `UIActionSheet` and a delegate:

    @property (nonatomic, strong) id someObject;

    - (void)showActionSheet:(id)something {
      self.someObject = something; // set property to access it later
      UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Title" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Destructive Button" otherButtonTitles:@"Button One", @"Button Two", nil];
      [actionSheet showInView:self.view];
    }

    - (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
      NSString *clickedButtonTitle = [actionSheet buttonTitleAtIndex:buttonIndex];

      if ([clickedButtonTitle isEqualToString:@"Destructive Button"]) {
        // do something when destructive button is tapped
      } else if ([clickedButtonTitle isEqualToString:@"Button One"]) {
        // do something when button one is tapped
      } else if ([clickedButtonTitle isEqualToString:@"Button Two"]) {
        // do something with self.someObject when button two is tapped
      }
    }

Converted to use `MEActionSheet`:

    - (void)showActionSheet:(id)something {
      MEActionSheet *actionSheet = [[MEActionSheet alloc] initWithTitle:@"Title"];

      // Example with block. This happens to be the destructive button.
      [actionSheet setDestructiveButtonWithTitle:@"Destructive Button" onTapped:^{
        // do something when "Destructive Button" is tapped
      }];

      // Example with target/action
      [actionSheet addButtonWithTitle:@"Button One" target:self action:@selector(buttonOneTapped)];

      // Example with target/action passing an object
      [actionSheet addButtonWithTitle:@"Button Two" target:self action:@selector(buttonTwoTapped:) withObject:something];

      // Add the cancel button to the end
      [actionSheet addCancelButtonWithTitle:@"Cancel"];

      [actionSheet showInView:self.view];
    }

    - (void)buttonOneTapped {
      // do something when "Button One" is tapped
    }

    - (void)buttonTwoTapped:(id)someObject {
      // do something with someObject when "Button Two" is tapped
    }

## Features

* Drop-in replacement for `UIActionSheet`. `MEActionSheet` is a subclass of `UIActionSheet` and the original API works as expected. The `UIActionSheetDelegate` works as well.
* Eliminates the long if...else if... or switch statement found in the delegate method `actionSheet:clickedButtonAtIndex:`. No more trying to match strings or figuring out which index of the button that was tapped.
* Results in smaller and re-usable methods using target/action.
* Simplifies the use of multiple action sheets per view controller. There is no need for the action sheet delegate method that tries to handle all the action sheets in one view controller.
* Simplifies passing objects to button actions. You used to have to store a local instance in the view controller and access it in the delegate method. Now, you can just use the object in a block or pass it in with `addButtonWithTitle:target:action:withObject`. See example above with passing the `something` object for "Button Two"

## Gotchas

* Order matters. The buttons added first will appear closer to the top.
* Don't forget to add the cancel button. Since order matters, you'll probably want to add it last so that it appears at the bottom.
* Destructive buttons usually appear at the top. You don't have to, but add it first.
* If you still need the `UIActionSheetDelegate` delegate, you can set it in the constructor `initWithTitle:delegate:`. Or set it through the `delegate` property.
* Don't mix and match `MEActionSheet` methods with `UIActionSheet` methods. Stick with one or the other.

## MIT License

Copyright (C) 2013 Mike Enriquez

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
of the Software, and to permit persons to whom the Software is furnished to do
so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
