# SilverPlate Framework [![Build Status](https://travis-ci.org/SilverPlate-Framework/silverplate-ios.svg?branch=master)](https://travis-ci.org/SilverPlate-Framework/silverplate-ios)
___
## Description
__SilverPlate__ is a Swift3 framework which elegantly brings some of the most important system events to you.

Easy to use, you do not need protocols/delegates nor to implement a gazillion methods into your neet classes as the __SilverPlate__ public API relies on simple closures.

___
## Implementation
- First, we need to give our application the permission to monitor the battery.
In your AppDelegate's application method, add this line:

```Swift3
UIDevice.currentDevice().batteryMonitoringEnabled = true
```

- In a ViewController or any other class, to respond to reachability status change:

```Swift3
import UIKit
import SilverPlate

class ViewController: UIViewController {
    @IBOutlet weak var netStatusLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        SilverPlate.shared.onInternetStatusChanged = { (status) in
            self.netStatusLabel.text = "Connectivity status: \(status)"

            switch status {
            case SilverPlate.Network.wifi:
                // Do some heavy download
                break
            case SilverPlate.Network.cellular:
                // Now easy with the data load
                break
            case SilverPlate.Network.none:
                // Don't try to fetch anything from the web
                break
            }
        }
    }
}
```
