import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var circularSlider: CircularSlider!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // Example usage in your ViewController
        let circularSlider = CircularSlider()
        //circularSlider.thumbImages = [UIImage(named: "Group 139757")!, UIImage(named: "Group 139759")!, UIImage(named: "Group 139760")!, UIImage(named: "Group 139761")!, UIImage(named: "Group 139762")!]

        circularSlider.addTarget(self, action: #selector(valueChanged), for: .valueChanged)
    }
    
    @objc func valueChanged() {
        print("Value changed: \(circularSlider.currentValues)")
    }
}

