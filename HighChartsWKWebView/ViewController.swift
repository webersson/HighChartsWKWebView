

import Cocoa
import WebKit
class ViewController: NSViewController, WKNavigationDelegate {
    
    var webView = WKWebView()
    
    private var userContentController: WKUserContentController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userContentController = WKUserContentController()
        let configuration = WKWebViewConfiguration()
        
        configuration.userContentController = userContentController
        let webView = WKWebView(frame: CGRect(x: 10, y: 10, width: 450, height: 200), configuration: configuration)
        
        view.addSubview(webView)
        self.webView = webView
        
        userContentController.removeAllUserScripts()
        
        let script =
        
//                "var viewport = document.querySelector(\"meta[name=viewport]\");" +
//                "viewport.setAttribute('content', 'width=device-width, initial-scale=0.4, user-scalable=0');" +
        
                "var chartDiv = document.querySelector('.col-xs-12.tab-content');" +
                "document.querySelectorAll('body > *').forEach(function(el) { el.style.display = 'none'; });" +
                
                "document.body.append(chartDiv);" +
                "document.body.style.webkitTransform = 'scale(0.5)';"
        
     
        let userScript = WKUserScript(source: script,
                                      injectionTime: WKUserScriptInjectionTime.atDocumentEnd,
                                      forMainFrameOnly: true)
        
        userContentController.addUserScript(userScript)

        webView.navigationDelegate = self
        
        let url = NSURL(string: "https://coinmarketcap.com/currencies/bitcoin/")!
        webView.load(NSURLRequest(url: url as URL) as URLRequest)
        
        
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        // self.webView.magnification = 0.5
        
        webView.evaluateJavaScript("document.getElementsByTagName('html')[0].innerHTML", completionHandler: { (innerHTML, error) in
            
            print(innerHTML)
            
        })
        
    }
    
}

