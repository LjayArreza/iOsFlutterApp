import UIKit
import Flutter

class ViewController: UIViewController {
    
    let flutterEngine = FlutterEngine()
    let CHANNEL_NAME = "ph.gocart.dismiss_flutter_channel"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let buttonWidth: CGFloat = 160.0
        let buttonHeight: CGFloat = 40.0
           
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
           
        let button = UIButton(type: .custom)
        button.addTarget(self, action: #selector(showFlutter), for: .touchUpInside)
        button.setTitle("Show Flutter!", for: .normal)
        button.frame = CGRect(x: (screenWidth - buttonWidth) / 2, y: (screenHeight - buttonHeight) / 2, width: buttonWidth, height: buttonHeight)
        button.backgroundColor = UIColor.blue
        self.view.addSubview(button)
    }
    
    @objc func showFlutter() {
        let flutterEngine = (UIApplication.shared.delegate as! AppDelegate).flutterEngine
        let flutterViewController = FlutterViewController(engine: flutterEngine, nibName: nil, bundle: nil)
        flutterViewController.modalPresentationStyle = .fullScreen
        flutterViewController.modalTransitionStyle = .coverVertical
        flutterViewController.pushRoute("/search-screen")
        present(flutterViewController, animated: true, completion: nil)
        let channel = FlutterMethodChannel(name: CHANNEL_NAME, binaryMessenger: flutterViewController.binaryMessenger)
        channel.setMethodCallHandler { [weak self] (call: FlutterMethodCall, result: FlutterResult) in
            self?.handleMethodCall(call, result: result)        }
    }
    
  
    private func handleMethodCall(_ call: FlutterMethodCall, result: FlutterResult) {
        switch call.method {
        case "dismissFlutter":
            self.dismiss(animated: true, completion: nil)
            result(nil)
        default:
            result(FlutterMethodNotImplemented)
        }
    }
}
